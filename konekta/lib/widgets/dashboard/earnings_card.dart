import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_colors.dart';

class EarningsCard extends StatelessWidget {
  final double thisMonthEarnings;
  final double pendingBalance;

  const EarningsCard({
    super.key,
    required this.thisMonthEarnings,
    required this.pendingBalance,
  });

  String _formatRupiah(double amount) => NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Expanded(
            child: Text("This Month's Earnings",
                style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
            child: const Text('This Month', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ]),
        const SizedBox(height: 8),
        Text(_formatRupiah(thisMonthEarnings),
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.5),
            overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        const Text('Automatically transferred to your registered bank account',
            style: TextStyle(color: Colors.white60, fontSize: 11, height: 1.4)),
        const SizedBox(height: 16),
        Divider(color: Colors.white.withValues(alpha: 0.2), thickness: 1),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Pending from Brands', style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(width: 8),
          Flexible(
            child: Text(_formatRupiah(pendingBalance),
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis),
          ),
        ]),
      ]),
    );
  }
}
