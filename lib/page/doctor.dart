import 'package:flutter/material.dart';
import '../services/doctor_service.dart';
import '../model/report_doctor_model.dart';

class DoctorPage extends StatefulWidget {
  final String initialDataType;

  DoctorPage({required this.initialDataType});

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  late String currentDataType;
  List<DoanhThu> reportData = [];
  final ScrollController _scrollController = ScrollController();
  final DoctorService _doctorService = DoctorService();

  @override
  void initState() {
    super.initState();
    currentDataType = widget.initialDataType;
    fetchReportData();
  }

  Future<void> fetchReportData() async {
    try {
      final data = await _doctorService.fetchReportData(currentDataType);
      setState(() {
        reportData = data;
      });
    } catch (e) {
      setState(() {
        reportData = [];
      });
    }
    _scrollController.jumpTo(0);
  }

  void _onTabButtonPressed(String dataType) {
    setState(() {
      currentDataType = dataType;
      fetchReportData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF294157),
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton(context, 'BÁC SĨ CHỈ ĐỊNH', currentDataType == 'BÁC SĨ CHỈ ĐỊNH'),
                  _buildTabButton(context, 'BÁC SĨ THỰC HIỆN', currentDataType == 'BÁC SĨ THỰC HIỆN'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildFilterButtons(context),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: reportData.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: reportData.length,
                  itemBuilder: (context, index) {
                    final item = reportData[index];
                    return _buildReportCard(
                      context,
                      item.ten ?? 'Unknown Title',
                      '${item.value.toString()} VND' ?? '0.0',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    final Color buttonColor = Colors.white.withOpacity(0.6);
    final Color textColor = Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => DateRangeSelector(),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: textColor, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Tháng này',
                    style: TextStyle(color: textColor, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
            ),
            child: Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String title, bool selected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _onTabButtonPressed(title);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: selected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, String title, String value) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            style: TextStyle(color: Colors.yellow),
          ),
        ],
      ),
    );
  }
}

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
