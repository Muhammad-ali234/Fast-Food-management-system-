// ignore_for_file: unused_import

import '../config/database.dart';
import '../models/employee.dart';
import '../models/attendance.dart';
import '../utils/db_utils.dart';

class EmployeeService {
  final DatabaseConfig _db;

  EmployeeService({DatabaseConfig? db}) : _db = db ?? DatabaseConfig();

  Future<List<Employee>> getEmployees() async {
    final conn = await _db.connection;
    final results = await conn.query('SELECT * FROM employees ORDER BY name');
    return results.map((row) => Employee.fromJson(row.toColumnMap())).toList();
  }

  Future<List<Attendance>> getTodayAttendance() async {
    final conn = await _db.connection;
    final results = await conn
        .query('SELECT a.*, e.name as employee_name FROM attendance a '
            'JOIN employees e ON a.employee_id = e.id '
            'WHERE DATE(a.check_in) = CURRENT_DATE');
    return results
        .map((row) => Attendance.fromJson(row.toColumnMap()))
        .toList();
  }

  Future<void> checkIn(int employeeId) async {
    final conn = await _db.connection;
    await conn.query(
      'INSERT INTO attendance (employee_id, check_in) VALUES (@id, CURRENT_TIMESTAMP)',
      substitutionValues: {'id': employeeId},
    );
  }

  Future<void> checkOut(int attendanceId) async {
    final conn = await _db.connection;
    await conn.query(
      'UPDATE attendance SET check_out = CURRENT_TIMESTAMP WHERE id = @id',
      substitutionValues: {'id': attendanceId},
    );
  }

  Future<Map<String, dynamic>> getEmployeeStats(int employeeId) async {
    final conn = await _db.connection;
    final results = await conn.query(
      'SELECT COUNT(*) as total_days, '
      'AVG(EXTRACT(EPOCH FROM (check_out - check_in))/3600) as avg_hours '
      'FROM attendance '
      'WHERE employee_id = @id AND check_out IS NOT NULL',
      substitutionValues: {'id': employeeId},
    );
    return results.first.toColumnMap();
  }
}
