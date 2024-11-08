import 'package:flutter/material.dart';
import 'package:login/utils/constants/colors.dart';
import 'package:login/utils/constants/constantStyle.dart';

class DefaultButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final Size? minimumSize;
  final double fontSize;
  final IconData? icon;
  final AlignmentGeometry? alignment;
  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.minimumSize,
    this.fontSize = 12,
    this.icon,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
      ),
      style: ElevatedButton.styleFrom(
        textStyle: ConstantStyle.defaultTextStyle(fontSize: fontSize),
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: ColorApp.button,
        alignment: alignment, // Memposisikan konten ke kiri
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
