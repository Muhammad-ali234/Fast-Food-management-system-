import 'package:flutter/foundation.dart';
import '../config/database.dart';
import '../models/employee.dart';
import '../models/attendance.dart';

class EmployeeProvider with ChangeNotifier {
  final DatabaseConfig _db = DatabaseConfig();
  List<Employee> _employees = [];
  List<Attendance> _todayAttendance = [];
  bool _isLoading = false;

  List<Employee> get employees => _employees;
  List<Attendance> get todayAttendance => _todayAttendance;
  bool get isLoading => _isLoading;

  // Load all employees from the database
  Future<void> loadEmployees() async {
    if (_isLoading) return; // Avoid calling loadEmployees multiple times

    _isLoading = true;
    try {
      final conn = await _db.connection;
      final results = await conn.query(
          'SELECT * FROM employees WHERE is_active = true ORDER BY name');
      _employees =
          results.map((row) => Employee.fromJson(row.toColumnMap())).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading employees: $e');
    }
  }

  // Search employees by name
  void searchEmployees(String query) {
    final searchQuery = query.toLowerCase();
    _employees = _employees.where((employee) {
      return employee.name.toLowerCase().contains(searchQuery);
    }).toList();
    loadEmployees();
    notifyListeners();
  }

  // Filter employees by active/inactive status
  void filterEmployees(String filter) {
    if (filter == 'active') {
      _employees = _employees.where((employee) => employee.isActive).toList();
    } else if (filter == 'inactive') {
      _employees = _employees.where((employee) => !employee.isActive).toList();
    } else {
      loadEmployees(); // Reload all employees if filter is 'all'
    }
    notifyListeners();
  }

  // Update an employee's details
  Future<void> updateEmployee(Employee updatedEmployee) async {
    try {
      final conn = await _db.connection;
      await conn.query(
        'UPDATE employees SET name = @name, role = @role, phone = @phone, email = @email, hire_date = @hire_date, salary = @salary WHERE id = @id',
        substitutionValues: {
          'id': updatedEmployee.id,
          'name': updatedEmployee.name,
          'role': updatedEmployee.role,
          'phone': updatedEmployee.phone,
          'email': updatedEmployee.email,
          'hire_date': updatedEmployee.hireDate.toIso8601String(),
          'salary': updatedEmployee.salary,
        },
      );
      // Reload employees after update
      await loadEmployees();
    } catch (e) {
      debugPrint('Error updating employee: $e');
    }
  }

  // Mark employee as inactive (soft delete)
  Future<void> setEmployeeInactive(int employeeId) async {
    try {
      final conn = await _db.connection;
      await conn.query(
        'UPDATE employees SET is_active = false WHERE id = @id',
        substitutionValues: {'id': employeeId},
      );
      // Reload employees after update
      await loadEmployees();
    } catch (e) {
      debugPrint('Error setting employee inactive: $e');
    }
  }

  // Load today's attendance
  Future<void> loadTodayAttendance() async {
    try {
      final conn = await _db.connection;
      final results = await conn
          .query('SELECT a.*, e.name as employee_name FROM attendance a '
              'JOIN employees e ON a.employee_id = e.id '
              'WHERE DATE(a.check_in) = CURRENT_DATE');
      _todayAttendance =
          results.map((row) => Attendance.fromJson(row.toColumnMap())).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading attendance: $e');
    }
  }

  // Add a new employee
  Future<void> addEmployee(Employee employee) async {
    try {
      final conn = await _db.connection;
      await conn.query(
        'INSERT INTO employees (name, role, phone, email, hire_date, salary) VALUES (@name, @role, @phone, @email, @hire_date, @salary)',
        substitutionValues: {
          'name': employee.name,
          'role': employee.role,
          'phone': employee.phone,
          'email': employee.email,
          'hire_date': employee.hireDate.toIso8601String(),
          'salary': employee.salary,
        },
      );
      // Reload the employees list after adding
      await loadEmployees();
    } catch (e) {
      debugPrint('Error adding employee: $e');
    }
  }

  // Check-in an employee
  Future<void> checkIn(int employeeId) async {
    try {
      final conn = await _db.connection;
      await conn.query(
        'INSERT INTO attendance (employee_id, check_in) VALUES (@id, CURRENT_TIMESTAMP)',
        substitutionValues: {'id': employeeId},
      );
      await loadTodayAttendance();
    } catch (e) {
      debugPrint('Error checking in: $e');
    }
  }

  // Check-out an employee
  Future<void> checkOut(int attendanceId) async {
    try {
      final conn = await _db.connection;
      await conn.query(
        'UPDATE attendance SET check_out = CURRENT_TIMESTAMP WHERE id = @id',
        substitutionValues: {'id': attendanceId},
      );
      await loadTodayAttendance();
    } catch (e) {
      debugPrint('Error checking out: $e');
    }
  }
}
