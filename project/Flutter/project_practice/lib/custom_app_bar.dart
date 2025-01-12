import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Gradient gradient;
  final TextStyle? titleTextStyle;

  GradientAppBar({
    required this.title,
    required this.gradient,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: AppBar(
        title: Text(
          title,
          style: titleTextStyle ?? TextStyle(color: Colors.white), // Default style
        ),
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove shadow
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
