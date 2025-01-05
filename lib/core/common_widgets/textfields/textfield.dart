import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Icon? prefixIcon;
  final bool isPassword; // Determines if this field is a password field
  final bool isEditable;
  final Color backgroundColor;
  final Icon? suffixIcon;
  final ValueChanged<String>? onChanged; // Added onChanged callback

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.isPassword = false, // Default to false
    this.isEditable = true,
    this.backgroundColor = AppColors.secondaryBackground,
    this.suffixIcon,
    this.onChanged, // Accept the onChanged callback
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText; // Tracks the visibility of the text
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _obscureText = widget.isPassword; // Set obscureText based on isPassword
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Set the fixed height for the text field
      child: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.start,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText, // Use the state variable
        focusNode: _focusNode,
        style: TextStyle(
          fontSize: 16,
          color: widget.isEditable ? Colors.black : Colors.grey,
        ),
        onChanged:
            widget.onChanged, // Pass the onChanged callback to TextFormField
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: TextStyles.h2g,
          hintStyle: TextStyles.h2g,
          filled: true,
          fillColor: widget.backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.titleColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Toggle visibility
                    });
                  },
                )
              : widget.suffixIcon,
          // Add error styling when the validation fails
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _focusNode.hasFocus
                  ? AppColors.primaryBackground // Focused border color
                  : widget.backgroundColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _focusNode.hasFocus
                  ? AppColors.primaryBackground
                  : widget.backgroundColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.red), // Red border when error occurs
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}
