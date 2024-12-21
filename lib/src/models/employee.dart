// class Employee {
//   final int id;
//   final String name;
//   final String role;
//   final String? phone;
//   final String? email;
//   final DateTime hireDate;
//   final double salary;

//   Employee({
//     required this.id,
//     required this.name,
//     required this.role,
//     this.phone,
//     this.email,
//     required this.hireDate,
//     required this.salary,
//   });

//   // factory Employee.fromJson(Map<String, dynamic> json) {
//   //   return Employee(
//   //     id: json['id'],
//   //     name: json['name'],
//   //     role: json['role'],
//   //     phone: json['phone'],
//   //     email: json['email'],
//   //     hireDate: DateTime.parse(json['hire_date']),
//   //     salary: json['salary'],
//   //   );
//   // }
// factory Employee.fromJson(Map<String, dynamic> json) {
//   return Employee(
//     id: json['id'],
//     name: json['name'],
//     role: json['role'],
//     phone: json['phone'],
//     email: json['email'],
//     hireDate: json['hire_date'] is String
//         ? DateTime.parse(json['hire_date'])
//         : json['hire_date'], // Handle DateTime properly
//     salary: json['salary'] is String
//         ? double.tryParse(json['salary']) ??
//             0.0 // Convert to double if it's a string
//         : json['salary'], // If it's already a double, use it directly
//   );
// }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'role': role,
//       'phone': phone,
//       'email': email,
//       'hire_date': hireDate.toIso8601String(),
//       'salary': salary,
//     };
//   }
// }

class Employee {
  final int id;
  final String name;
  final String role;
  final String? phone;
  final String? email;
  final DateTime hireDate;
  final double salary;
  bool isActive; // Add this field

  Employee({
    required this.id,
    required this.name,
    required this.role,
    this.phone,
    this.email,
    required this.hireDate,
    required this.salary,
    this.isActive = true, // Default to active
  });

  // factory Employee.fromJson(Map<String, dynamic> json) {
  //   return Employee(
  //     id: json['id'],
  //     name: json['name'],
  //     role: json['role'],
  //     phone: json['phone'],
  //     email: json['email'],
  //     hireDate: DateTime.parse(json['hire_date']),
  //     salary: json['salary'],
  //     isActive: json['is_active'] ??
  //         true, // Assuming `is_active` is a field in your database
  //   );
  // }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      phone: json['phone'],
      email: json['email'],
      hireDate: json['hire_date'] is String
          ? DateTime.parse(json['hire_date'])
          : json['hire_date'], // Handle DateTime properly
      salary: json['salary'] is String
          ? double.tryParse(json['salary']) ??
              0.0 // Convert to double if it's a string
          : json['salary'], // If it's already a double, use it directly
      isActive: json['is_active'] ??
          true, // Assuming `is_active` is a field in your database
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'phone': phone,
      'email': email,
      'hire_date': hireDate.toIso8601String(),
      'salary': salary,
      'is_active': isActive, // Include this when saving to DB
    };
  }
}
