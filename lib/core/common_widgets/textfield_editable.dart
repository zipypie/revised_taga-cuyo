import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class TextfieldWithEditIcon extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const TextfieldWithEditIcon({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  State<TextfieldWithEditIcon> createState() => _TextfieldWithEditIconState();
}

class _TextfieldWithEditIconState extends State<TextfieldWithEditIcon> {
  bool _isEditable = false; // Track if the field is editable
  late FocusNode _focusNode; // FocusNode to manage the focus

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Initialize the FocusNode
  }

  // This will be called when the edit icon is tapped
  void _toggleEditable() {
    setState(() {
      _isEditable = !_isEditable; // Toggle the editable state
    });

    if (_isEditable) {
      // Request focus when editable
      FocusScope.of(context).requestFocus(_focusNode);
    } else {
      // Unfocus when not editable
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose of the FocusNode when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      readOnly: !_isEditable, // Field is read-only until icon is clicked
      focusNode: _focusNode, // Use the focus node to manage focus
      style: TextStyle(
        fontFamily: AppFonts.fcb,
        fontSize: 18,
        color: _isEditable
            ? Colors.black
            : Colors.grey, // Text color changes based on editability
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyles.h2b,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.edit,
            color: _isEditable
                ? AppColors.wrong
                : Colors.blue, // Change color based on edit state
          ),
          onPressed: _toggleEditable, // Toggle editable when icon is tapped
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: _isEditable
            ? AppColors.secondaryBackground
            : AppColors.secondaryBackground
                .withOpacity(0.7), // Apply opacity when not editable
      ),
    );
  }
}
