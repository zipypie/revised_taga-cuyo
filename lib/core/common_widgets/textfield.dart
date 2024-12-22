import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Icon? prefixIcon; // Optional prefix icon
  final bool isPassword; // Whether this is a password field
  final bool isEditable; // Whether the field should be editable
  final Color backgroundColor; // Custom background color for the field
  final Icon? suffixIcon; // Optional suffix icon

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.isPassword = false, // Default to false (not a password field)
    this.isEditable = false, // Default to editable
    this.backgroundColor =
        AppColors.secondaryBackground, // Default background color
    this.suffixIcon, // Optional suffix icon
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late bool _isEditable;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText =
        widget.isPassword; // Set the password field visibility toggle
    _isEditable =
        widget.isEditable; // Set the editability based on passed value
    _focusNode = FocusNode();
  }

  // Function to toggle the password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlign: TextAlign.start,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      readOnly: !_isEditable, // Read-only unless editable is true
      focusNode: _focusNode,
      style: TextStyle(
        fontSize: 18,
        color: _isEditable
            ? Colors.black
            : Colors.grey, // Text color based on editability
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: TextStyle(color: AppColors.titleColor),
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: widget.backgroundColor, // Apply custom background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.prefixIcon, // Add prefix icon if available
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.titleColor,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null), // Only display the password toggle or custom suffix icon
      ),
      validator: widget.validator,
    );
  }
}
