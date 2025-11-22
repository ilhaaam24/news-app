import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = Colors.blue,
    this.titleColor = Colors.white,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color color;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: titleColor, fontSize: 18)),
    );
  }
}
