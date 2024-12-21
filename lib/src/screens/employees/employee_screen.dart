import 'package:ffms/src/widgets/employees/add_employee_dialog.dart';
import 'package:flutter/material.dart';
import '../../widgets/side_menu.dart';
import '../../widgets/employees/employee_list.dart';
import '../../widgets/employees/attendance_tracker.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Employee Management',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const Dialog(
                              child: SizedBox(
                                width: 600,
                                child: AddEmployeeDialog(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person_add),
                        label: const Text('Add Employee'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: EmployeeList(),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: AttendanceTracker(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
