import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../widgets/form_item.dart';
import '../models/user_profile.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Sử dụng model để quản lý dữ liệu
  final UserProfile _userProfile = UserProfile();
  
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  final List<String> _genders = ['Nam', 'Nữ', 'Khác'];
  final List<String> _maritalOptions = ['Độc thân', 'Kết hôn', 'Ly hôn'];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Cập nhật dữ liệu vào model
      _userProfile.name = _nameController.text;
      _userProfile.age = int.parse(_ageController.text);
      // gender, maritalStatus, income đã được cập nhật trực tiếp qua setState
      
      print('Dữ liệu đã lưu: ${_userProfile.toString()}');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lưu thành công: ${_userProfile.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004D40),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'FORM THÔNG TIN CÁ NHÂN',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Họ và tên
              FormItem(
                label: 'Họ và tên',
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tên của bạn',
                  ),
                  validator: (value) => Validators.requiredField(value, 'Họ và tên'),
                ),
              ),

              // Tuổi
              FormItem(
                label: 'Tuổi',
                child: TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tuổi của bạn',
                  ),
                  validator: Validators.ageValidator,
                ),
              ),

              // Giới tính (Dropdown)
              FormItem(
                label: 'Giới tính',
                child: DropdownButtonFormField<String>(
                  value: _userProfile.gender.isEmpty ? null : _userProfile.gender,
                  hint: const Text('Chọn giới tính'),
                  items: _genders.map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userProfile.gender = value!;
                    });
                  },
                  validator: (value) => value == null ? 'Vui lòng chọn giới tính' : null,
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'Tình trạng hôn nhân',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ..._maritalOptions.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _userProfile.maritalStatus,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      _userProfile.maritalStatus = value!;
                    });
                  },
                );
              }).toList(),

              const SizedBox(height: 16),
              const Text(
                'Mức thu nhập',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Center(
                child: Text(
                  'Mức: ${_userProfile.income.toInt()} tr VND',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Slider(
                value: _userProfile.income,
                min: 0,
                max: 30,
                divisions: 30,
                label: '${_userProfile.income.toInt()} tr VND',
                activeColor: const Color(0xFF004D40),
                onChanged: (value) {
                  setState(() {
                    _userProfile.income = value;
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0\ntr VND', textAlign: TextAlign.center),
                    Text('10\ntr VND', textAlign: TextAlign.center),
                    Text('20\ntr VND', textAlign: TextAlign.center),
                    Text('30+\ntr VND', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF004D40),
        onPressed: _saveForm,
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}
