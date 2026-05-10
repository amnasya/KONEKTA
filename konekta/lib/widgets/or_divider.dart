import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class OrDivider extends StatelessWidget {
  final String text;
  const OrDivider({super.key, this.text = 'or'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.dividerGray, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: const TextStyle(color: AppColors.grayText, fontSize: 13),
          ),
        ),
        Expanded(child: Divider(color: AppColors.dividerGray, thickness: 1)),
      ],
    );
  }
}
