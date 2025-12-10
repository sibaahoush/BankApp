import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class NewScheduledPaymentScreen extends StatelessWidget {
  const NewScheduledPaymentScreen({super.key});
  static const routename = "newScheduledPayment";

  @override
  Widget build(BuildContext context) {
    final accountIdController = TextEditingController();
    final relatedAccountIdController = TextEditingController();
    final amountController = TextEditingController();
    final nextRunController = TextEditingController();

    String selectedType = "invoice";
    String selectedFrequency = "monthly";

    final types = ["invoice", "subscription", "loan_payment"];
    final frequencies = ["daily", "weekly", "monthly", "yearly"];

    return Scaffold(
      appBar: AppBar(title: const Text("New schedule transaction")),
      body: StatefulBuilder(
        builder: (context, setState) {
          final theme = Theme.of(context);

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Account ID", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: accountIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "e.g. 123"),
                ),

                const SizedBox(height: 16),

                Text("Amount", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "e.g. 11000",
                    prefixText: "\$ ",
                  ),
                ),

                const SizedBox(height: 16),

                Text("Type", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                _ThemedDropdown(
                  value: selectedType,
                  items: types,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() => selectedType = v);
                  },
                ),

                const SizedBox(height: 16),

                Text("Frequency", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                _ThemedDropdown(
                  value: selectedFrequency,
                  items: frequencies,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() => selectedFrequency = v);
                  },
                ),

                const SizedBox(height: 16),

                Text(
                  "Next run (date & time)",
                  style: theme.textTheme.labelSmall,
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: nextRunController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    hintText: "2025-12-08 08:10:00",
                    prefixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  ),
                ),

                const SizedBox(height: 16),

                Text("Account related ID", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: relatedAccountIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "e.g. 321"),
                ),

                const SizedBox(height: 200),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: const BorderSide(
                            color: AppColors.primary,

                            // أو AppColors.primary إذا استوردتيه
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // POST /api/scheduled-transactions لاحقاً
                        },
                        child: const Text("Create"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ThemedDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _ThemedDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(10),
        border: const Border.fromBorderSide(
          BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items:
              items
                  .map(
                    (t) => DropdownMenuItem(
                      value: t,
                      child: Text(t, style: theme.textTheme.bodySmall),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
