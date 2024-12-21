import 'package:flutter/material.dart';

class AttendanceTracker extends StatelessWidget {
  const AttendanceTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Attendance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final isCheckedIn = index % 2 == 0;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isCheckedIn ? Colors.green : Colors.grey,
                        child: Icon(
                          isCheckedIn ? Icons.check : Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      title: Text('Employee ${index + 1}'),
                      subtitle: Text(
                        isCheckedIn ? 'Checked in at 9:00 AM' : 'Not checked in',
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          // TODO: Toggle attendance
                        },
                        child: Text(
                          isCheckedIn ? 'Check Out' : 'Check In',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}