import 'package:flutter/material.dart';

class CustomOption extends StatelessWidget {
  final String title;
  final int index;
  final bool isSelected;
  final Function() onTap;

  const CustomOption({
    required this.title,
    required this.index,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey,
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
