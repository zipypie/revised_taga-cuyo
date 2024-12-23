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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.start,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText, // Use the state variable
        focusNode: _focusNode,
        style: TextStyle(
          fontSize: 18,
          color: widget.isEditable ? Colors.black : Colors.grey,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: TextStyle(
              color: AppColors.grey, fontFamily: AppFonts.fcb, fontSize: 21),
          hintStyle: TextStyle(color: Colors.grey, fontFamily: AppFonts.fcb),
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
        ),
        validator: widget.validator,
      ),
    );
  }
}
