import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../utils/validators.dart';
import '../models/job_application.dart';

class UploadCvPage extends StatefulWidget {
  const UploadCvPage({super.key});

  @override
  State<UploadCvPage> createState() => _UploadCvPageState();
}

class _UploadCvPageState extends State<UploadCvPage> {
  final _formKey = GlobalKey<FormState>();
  final _application = JobApplication();
  
  // Controllers are still useful for initial values and focus, 
  // but we will sync data to the model.
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  
  bool _fileError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null) {
      setState(() {
        _application.cvFileName = result.files.single.name;
        _fileError = false;
      });
    }
  }

  void _submitForm() {
    // Trigger onSaved for text fields
    _formKey.currentState!.save();
    
    setState(() {
      _fileError = _application.cvFileName == null;
    });

    if (_formKey.currentState!.validate() && !_fileError && _application.isConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nộp hồ sơ thành công!')),
      );
    } else if (!_application.isConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng xác nhận thông tin!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004D40),
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text(
          'Bài 5: Form upload hồ sơ',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Họ và tên',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Nguyen Lan Huong',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _application.fullName = value ?? '',
                validator: (value) => Validators.requiredField(value, 'Họ và tên'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Hint Email',
                  hintText: 'lanhuong.nguyen@example.com',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _application.email = value ?? '',
                validator: Validators.emailValidator,
              ),
              const SizedBox(height: 20),
              const Text(
                'File Picker',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'CV (Định dạng: PDF, DOCX)',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: _fileError ? Colors.red : Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Chọn Tệp CV'),
                    ),
                    const SizedBox(width: 10),
                    if (_application.cvFileName != null)
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                _application.cvFileName!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (_fileError)
                const Padding(
                  padding: EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    'Vui lòng upload CV của bạn!',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _application.isConfirmed,
                    onChanged: (value) {
                      setState(() {
                        _application.isConfirmed = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text('Tôi xác nhận thông tin là chính xác.'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0AD4E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Nộp Hồ Sơ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
