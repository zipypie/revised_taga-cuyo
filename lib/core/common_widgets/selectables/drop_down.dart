import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class DropDown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String hintText;
  final String? labelText;
  final String? Function(String?)? validator; // Add the validator property

  const DropDown({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    required this.hintText,
    this.labelText,
    this.validator, // Initialize the validator
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    // Determine if an item is selected to apply dynamic styles
    final bool isSelected = widget.value != null && widget.value!.isNotEmpty;

    return DropdownButtonFormField<String>(
      value: widget.value,
      isExpanded: true,
      hint: Text(
        widget.hintText,
        style: TextStyles.h2g,
      ),
      dropdownColor: AppColors.secondaryBackground,
      items: widget.items.map((String item) {
        final bool isItemSelected = item == widget.value;
        return DropdownMenuItem<String>(
          value: item,
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isItemSelected
                  ? AppColors.accentColor
                  : AppColors
                      .secondaryBackground, // Non-selected items also match the container
            ),
            child: Text(
              item,
              style: TextStyle(
                color: isItemSelected
                    ? AppColors.primaryBackground
                    : AppColors
                        .titleColor, // Different text color for selected vs non-selected items
                fontSize: 18,
                fontWeight: FontWeight.w500, // Improved text weight
                fontFamily: AppFonts.fcb,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,

      style: TextStyle(color: AppColors.titleColor),
      decoration: InputDecoration(
        labelText: widget.labelText, // Add labelText for better UX
        labelStyle: TextStyle(
          color:
              AppColors.titleColor.withValues(alpha: 0.7), // Faded label color
        ),
        filled: true,
        fillColor: isSelected
            ? AppColors.accentColor
            : AppColors.secondaryBackground, // Background color
        border: OutlineInputBorder(
          borderSide: BorderSide.none, // Remove red border for validation
          borderRadius: BorderRadius.circular(12), // Smooth rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none, // Remove border
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none, // Remove border
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.red), // Red border when error occurs
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red), // Red border when error occurs and focused
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      validator: widget.validator, // Add the validator here
    );
  }
}
