import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: context.read<DashboardProvider>().setSearch,
      style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
      decoration: InputDecoration(
        hintText: 'Search campaigns…',
        hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFFAAAAAA), size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
