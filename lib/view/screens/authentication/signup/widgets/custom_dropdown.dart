import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final String labelText;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        label: Text(
          labelText,
          style: TextStyle(fontSize: 14.sp),
        ),
        labelStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconSize: 25.sp,
      isExpanded: true,
      value: value,
      hint: Text(hint, style: TextStyle(fontSize: 14.sp)),
      onChanged: onChanged,
      validator: validator,
      items: items,
    );
  }
}
