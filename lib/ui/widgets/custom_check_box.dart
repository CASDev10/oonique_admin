import 'package:flutter/material.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?)? onChanged;
  const CustomCheckBox({
    super.key,
    required this.title,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: Colors.white,
          side: BorderSide(color: context.colorScheme.primary, width: 2),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colorScheme.primary),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(title, style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}
