import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../utils/date_utils.dart';

class ExportReportDialog extends StatefulWidget {
  const ExportReportDialog({super.key});

  @override
  State<ExportReportDialog> createState() => _ExportReportDialogState();
}

class _ExportReportDialogState extends State<ExportReportDialog> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  final List<String> _selectedReports = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Export Report'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Start Date'),
            subtitle: Text(DateTimeUtils.formatDate(_startDate)),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2000),
                  lastDate: _endDate,
                );
                if (date != null) {
                  setState(() => _startDate = date);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('End Date'),
            subtitle: Text(DateTimeUtils.formatDate(_endDate)),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _endDate,
                  firstDate: _startDate,
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _endDate = date);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text('Select Reports to Include:'),
          CheckboxListTile(
            title: const Text('Sales Summary'),
            value: _selectedReports.contains('sales'),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _selectedReports.add('sales');
                } else {
                  _selectedReports.remove('sales');
                }
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Inventory Status'),
            value: _selectedReports.contains('inventory'),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _selectedReports.add('inventory');
                } else {
                  _selectedReports.remove('inventory');
                }
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Expense Report'),
            value: _selectedReports.contains('expenses'),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _selectedReports.add('expenses');
                } else {
                  _selectedReports.remove('expenses');
                }
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _selectedReports.isEmpty ? null : _generateReport,
          child: const Text('Generate PDF'),
        ),
      ],
    );
  }

  Future<void> _generateReport() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Business Report'),
              ),
              pw.Paragraph(
                text:
                    'Period: ${DateTimeUtils.formatDate(_startDate)} to ${DateTimeUtils.formatDate(_endDate)}',
              ),
              // Add report sections based on _selectedReports
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
