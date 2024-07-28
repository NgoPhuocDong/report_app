import 'package:flutter/material.dart';

class DateRangeSelector extends StatefulWidget {
  @override
  _DateRangeSelectorState createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Chọn khoảng thời gian',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _buildDateSelector('Từ:', _fromDate, (date) => setState(() => _fromDate = date)),
            SizedBox(height: 10),
            _buildDateSelector('Đến:', _toDate, (date) => setState(() => _toDate = date)),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Tìm kiếm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(String label, DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 50,
          child: Text(label, style: TextStyle(fontSize: 16)),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              DateTime? selected = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selected != null && selected != selectedDate) {
                onDateSelected(selected);
              }
            },
            child: Text(selectedDate == null
                ? 'Chọn ngày'
                : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }
}
