import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Gradient gradient;
  final TextStyle? titleTextStyle;
  final List<Widget>? actions;

  GradientAppBar({
    required this.title,
    required this.gradient,
    this.titleTextStyle,
    this.actions
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
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
