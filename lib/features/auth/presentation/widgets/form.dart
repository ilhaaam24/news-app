import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final bool isPassword;
  const CustomFormField({
    super.key,
    required this.label,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 4),
        TextFormField(
          obscureText: isPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: isPassword ? Icon(Icons.visibility) : null,
          ),
        ),
      ],
    );
  }
}
