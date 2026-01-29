import 'package:flutter/material.dart';

class SearchFilterChip extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String hint;
  final TextInputType? keyboardType;
  final VoidCallback? onClear;

  const SearchFilterChip({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.hint,
    this.keyboardType,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasText = controller.text.isNotEmpty;
    final primaryColor = Theme.of(context).primaryColor;
    
    return Container(
      height: 44,
      decoration: BoxDecoration(
        gradient: hasText 
            ? LinearGradient(
                colors: [
                  primaryColor.withValues(alpha: 0.15),
                  primaryColor.withValues(alpha: 0.20),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: hasText ? null : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasText ? primaryColor : primaryColor.withValues(alpha: 1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: hasText 
                ? primaryColor.withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: hasText ? 6 : 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 13,
          fontWeight: hasText ? FontWeight.w500 : FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 12,
            color: hasText ? primaryColor : Colors.grey.shade700,
            fontWeight: hasText ? FontWeight.w600 : FontWeight.w500,
          ),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          prefixIcon: Icon(
            icon, 
            size: 18, 
            color: hasText ? primaryColor : Colors.grey.shade600,
          ),
          suffixIcon: hasText
              ? IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 18,
                  icon: Icon(Icons.cancel, color: primaryColor),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          isDense: true,
        ),
      ),
    );
  }
}
