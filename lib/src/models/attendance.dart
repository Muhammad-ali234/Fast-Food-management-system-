class Attendance {
  final int id;
  final int employeeId;
  final String employeeName;
  final DateTime checkIn;
  final DateTime? checkOut;

  Attendance({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.checkIn,
    this.checkOut,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      checkIn: DateTime.parse(json['check_in']),
      checkOut: json['check_out'] != null ? DateTime.parse(json['check_out']) : null,
    );
  }
}