import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../models/booking_model.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_dropdown_form_field.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  
  final BookingModel _bookingData = BookingModel();

  final List<String> _services = [
    'Kiểm tra tổng quát',
    'Dịch vụ 2',
    'Dịch vụ 3',
  ];

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _bookingData.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _bookingData.date = picked;
        _dateController.text = _formatDate(picked);
      });
      _formKey.currentState?.validate();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _bookingData.time = picked.format(context);
        _timeController.text = _bookingData.time!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00332E),
        title: const Text(
          'ĐẶT LỊCH HẸN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chọn ngày',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _dateController,
                label: 'Chọn ngày',
                hintText: 'Chọn ngày',
                readOnly: true,
                onTap: () => _selectDate(context),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month, color: Colors.brown),
                  onPressed: () => _selectDate(context),
                ),
                validator: (value) => Validators.dateValidator(_bookingData.date),
              ),
              const SizedBox(height: 20),
              const Text(
                'Chọn giờ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _timeController,
                label: 'Chọn giờ',
                hintText: 'Chọn giờ',
                readOnly: true,
                onTap: () => _selectTime(context),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined),
                  onPressed: () => _selectTime(context),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Vui lòng chọn giờ' : null,
              ),
              const SizedBox(height: 20),
              const Text(
                'Chọn dịch vụ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              CustomDropdownFormField(
                label: 'Chọn dịch vụ',
                value: _bookingData.service,
                items: _services,
                onChanged: (String? newValue) {
                  setState(() {
                    _bookingData.service = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Vui lòng chọn dịch vụ' : null,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đặt lịch thành công!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Xác nhận Đặt lịch',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
