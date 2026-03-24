import 'package:flutter/material.dart';
import '../models/survey_model.dart';
import '../widgets/form_item.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final _formKey = GlobalKey<FormState>();

  // Dữ liệu sử dụng Model
  final List<Interest> _interests = [
    Interest(title: 'Phim ảnh (Movies)', icon: Icons.movie),
    Interest(title: 'Thể thao (Sports)', icon: Icons.sports_soccer),
    Interest(title: 'Âm nhạc (Music)', icon: Icons.music_note),
    Interest(title: 'Du lịch (Travel)', icon: Icons.card_travel),
  ];

  final List<SatisfactionLevel> _satisfactionOptions = [
    SatisfactionLevel(title: 'Hài lòng (Satisfied)', icon: Icons.sentiment_satisfied_alt),
    SatisfactionLevel(title: 'Bình thường (Neutral)', icon: Icons.sentiment_neutral),
    SatisfactionLevel(title: 'Chưa hài lòng (Unsatisfied)', icon: Icons.sentiment_dissatisfied),
  ];

  String? _selectedSatisfaction = 'Hài lòng (Satisfied)';
  final _notesController = TextEditingController();
  bool _showCheckboxError = false;

  void _submitForm() {
    setState(() {
      _showCheckboxError = !_interests.any((item) => item.isSelected);
    });

    if (_formKey.currentState!.validate() && !_showCheckboxError) {
      // Tạo đối tượng SurveyData từ thông tin đã nhập
      final result = SurveyData(
        interests: _interests.where((i) => i.isSelected).toList(),
        satisfactionLevel: _selectedSatisfaction,
        notes: _notesController.text,
      );
      
      print('Survey Submitted: ${result.satisfactionLevel}');
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cảm ơn bạn đã tham gia khảo sát!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section: SỞ THÍCH
              FormItem(
                label: 'SỞ THÍCH (INTERESTS)',
                child: Column(
                  children: _interests.map((interest) {
                    return CheckboxListTile(
                      title: Row(
                        children: [
                          Icon(interest.icon, color: Colors.grey[700]),
                          const SizedBox(width: 12),
                          Text(interest.title),
                        ],
                      ),
                      value: interest.isSelected,
                      onChanged: (val) {
                        setState(() {
                          interest.isSelected = val ?? false;
                          if (interest.isSelected) _showCheckboxError = false;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
              ),

              // Validation Error for Checkbox
              if (_showCheckboxError)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Validate', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            Text('Bạn phải chọn ít nhất 1 sở thích', style: TextStyle(color: Colors.red, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              // Section: MỨC ĐỘ HÀI LÒNG
              FormItem(
                label: 'MỨC ĐỘ HÀI LÒNG (SATISFACTION LEVEL)',
                child: Column(
                  children: _satisfactionOptions.map((option) {
                    return RadioListTile<String>(
                      title: Row(
                        children: [
                          Icon(option.icon, color: Colors.grey[700]),
                          const SizedBox(width: 12),
                          Text(option.title),
                        ],
                      ),
                      value: option.title,
                      groupValue: _selectedSatisfaction,
                      onChanged: (val) {
                        setState(() {
                          _selectedSatisfaction = val;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
              ),

              // Section: GHI CHÚ
              FormItem(
                label: 'GHI CHÚ THÊM (ADDITIONAL NOTES)',
                child: TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Ghi chú thêm...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text(
                  'Gửi Khảo Sát',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
