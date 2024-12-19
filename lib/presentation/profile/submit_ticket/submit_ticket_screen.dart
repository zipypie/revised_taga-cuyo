import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taga_cuyo/core/common_widgets/big_textfield.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfield.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class SubmitTicketScreen extends StatefulWidget {
  const SubmitTicketScreen({super.key});

  @override
  State<SubmitTicketScreen> createState() => _SubmitTicketScreenState();
}

class _SubmitTicketScreenState extends State<SubmitTicketScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit a Ticket', style: TextStyles.h1b),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Need help? ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleColor,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Please fill out the form below to submit a ticket, and our support team will get back to you as soon as possible.",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 30),

              // Name Field
              CustomTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name'),
              SizedBox(height: 20),

              // Email field
              CustomTextField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'Enter your email address'),
              SizedBox(height: 20),

              BigTextfield(
                controller: _issueController,
                hintText: 'Describe the issue with the app',
                maxLines: 7,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 20),

              // Image Picker Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Add Image:", style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.add_a_photo, color: AppColors.primary),
                    onPressed: _pickImage,
                  ),
                ],
              ),

              // Display the selected image
              if (_selectedImage != null)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              SizedBox(height: 30),

              // Submit Button
              CustomButton(onTab: () {}, text: 'Submit Ticket')
            ],
          ),
        ),
      ),
    );
  }
}
