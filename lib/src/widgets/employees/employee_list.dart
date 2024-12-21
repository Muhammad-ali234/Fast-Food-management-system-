import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/employee.dart';
import '../../providers/employee_provider.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeProvider>().loadEmployees();
    });
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<EmployeeProvider>(
          builder: (context, employeeProvider, child) {
            final employees = employeeProvider.employees;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search employees...',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          employeeProvider.searchEmployees(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: 'all',
                      items: const [
                        DropdownMenuItem(
                            value: 'all', child: Text('All Employees')),
                        DropdownMenuItem(
                            value: 'active', child: Text('Active')),
                        DropdownMenuItem(
                            value: 'inactive', child: Text('Inactive')),
                      ],
                      onChanged: (value) {
                        employeeProvider.filterEmployees(value!);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      final employee = employees[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(employee.name),
                          subtitle: Text('Role: ${employee.role}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDialog(
                                      context, employee, employeeProvider);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // Mark employee as inactive instead of deleting
                                  employeeProvider
                                      .setEmployeeInactive(employee.id);
                                },
                              ),
                            ],
                          ),
                          // Adding onTap to show employee details in popup
                          onTap: () {
                            _showEmployeeDetailsPopup(context, employee);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Show edit dialog to update employee details
  void _showEditDialog(BuildContext context, Employee employee,
      EmployeeProvider employeeProvider) {
    TextEditingController nameController =
        TextEditingController(text: employee.name);
    TextEditingController phoneController =
        TextEditingController(text: employee.phone);
    TextEditingController emailController =
        TextEditingController(text: employee.email);
    TextEditingController salaryController =
        TextEditingController(text: employee.salary.toString());
    String role = employee.role;
    DateTime hireDate = employee.hireDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Employee'),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: role,
                  decoration: const InputDecoration(labelText: 'Role'),
                  items: ['Cashier', 'Cook', 'Delivery Staff', 'Manager']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: (value) => role = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Required';
                    if (double.tryParse(value!) == null)
                      return 'Invalid salary';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Hire Date'),
                  subtitle: Text(
                    '${hireDate.year}-${hireDate.month}-${hireDate.day}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: hireDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        hireDate = date;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedEmployee = Employee(
                  id: employee.id,
                  name: nameController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                  role: role,
                  salary: double.parse(salaryController.text),
                  hireDate: hireDate,
                  isActive: employee.isActive,
                );
                employeeProvider.updateEmployee(updatedEmployee);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // // Show employee details in a popup when tapped
  // void _showEmployeeDetailsPopup(BuildContext context, Employee employee) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Employee Details - ${employee.name}'),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Role: ${employee.role}'),
  //             Text('Phone: ${employee.phone}'),
  //             Text('Email: ${employee.email}'),
  //             Text('Salary: \$${employee.salary}'),
  //             Text(
  //                 'Hire Date: ${employee.hireDate.year}-${employee.hireDate.month}-${employee.hireDate.day}'),
  //             Text('Status: ${employee.isActive ? "Active" : "Inactive"}'),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  // Show employee details in a popup when tapped
  void _showEmployeeDetailsPopup(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Employee Details - ${employee.name}'),
          content: SingleChildScrollView(
            // Allows the content to take only the needed height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Role: ${employee.role}'),
                Text('Phone: ${employee.phone}'),
                Text('Email: ${employee.email}'),
                Text('Salary: \$${employee.salary}'),
                Text(
                    'Hire Date: ${employee.hireDate.year}-${employee.hireDate.month}-${employee.hireDate.day}'),
                Text('Status: ${employee.isActive ? "Active" : "Inactive"}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
