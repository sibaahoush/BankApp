import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class WithdrawTransactionScreen extends StatelessWidget {
  const WithdrawTransactionScreen({super.key});
  static const routename = "WithdrawTransactionScreen";

  @override
  Widget build(BuildContext context) {
    final driverOptions = ["stripe", "paypal", "braintree"];
    String selectedDriver = "stripe";

    final tokenController = TextEditingController();
    final amountController = TextEditingController();
    final accountIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Withdraw")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // نوع بوابة السحب
                Text(
                  "Withdrawal driver (gateway)",
                  style: theme.textTheme.labelSmall,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(10),
                    //border: const BorderSide(color: Color(0xFFE5E7EB))
                    border: const Border.fromBorderSide(
                      BorderSide(color: Color(0xFFE5E7EB), width: 1),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedDriver,
                      isExpanded: true,
                      items:
                          driverOptions
                              .map(
                                (d) => DropdownMenuItem(
                                  value: d,
                                  child: Text(
                                    d,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => selectedDriver = value);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // التوكن (من البطاقة/المحفظة)
                Text("Withdrawal token", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: tokenController,
                  decoration: const InputDecoration(
                    hintText: "e.g. tok_visa / wallet_token",
                  ),
                ),

                const SizedBox(height: 16),

                // المبلغ
                Text("Amount", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "e.g. 250",
                    prefixText: "\$ ",
                  ),
                ),

                const SizedBox(height: 16),

                // رقم حساب العميل داخل البنك
                Text("Account ID", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: accountIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "e.g. 123"),
                ),

                const Spacer(),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: const BorderSide(
                            color:
                                AppColors.primary, // 🔥 الحواف باللون الأساسي
                            width: 1.2,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // لاحقاً: POST /api/withdraw
                        },
                        child: const Text("Withdraw now"),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
