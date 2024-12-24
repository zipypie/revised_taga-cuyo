import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class DropDown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String hintText;
  final String? labelText;

  const DropDown({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    required this.hintText,
    this.labelText,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    // Determine if an item is selected to apply dynamic styles
    final bool isSelected = widget.value != null && widget.value!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? AppColors.accentColor
              : AppColors.secondaryBackground,
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 5), // Added padding for better appearance
        child: DropdownButtonFormField<String>(
          dropdownColor: AppColors.secondaryBackground,
          value: widget.value,
          isExpanded: true,
          hint: Text(
            widget.hintText,
            style: TextStyles.h2g,
          ),
          items: widget.items.map((String item) {
            final bool isItemSelected = item == widget.value;
            return DropdownMenuItem<String>(
              value: item,
              child: Container(
                decoration: BoxDecoration(
                  color: isItemSelected
                      ? AppColors.accentColor
                      : AppColors
                          .secondaryBackground, // Set background color for selected item
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: isItemSelected
                        ? AppColors.primaryBackground
                        : AppColors.titleColor, // Text color for selected
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                    fontFamily: AppFonts.fcb,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: widget.onChanged,
          style: TextStyle(color: AppColors.titleColor), // Default text color
          decoration: InputDecoration(
            border: InputBorder.none, // Removed fillColor
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(Icons.arrow_drop_down, color: Colors.black45),
          ),
        ),
      ),
    );
  }
}
