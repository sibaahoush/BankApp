import 'package:flutter/material.dart';

void showPayBottomSheet(BuildContext context) {
  final driverOptions = ["stripe", "paypal", "braintree"];
  String selectedDriver = "stripe";

  final tokenController = TextEditingController();
  final amountController = TextEditingController();
  final accountIdController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final theme = Theme.of(context);

      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الـ handle الصغير فوق
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),

                Text(
                  "Pay with card",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                // driver
                Text(
                  "Payment driver (gateway)",
                  style: theme.textTheme.labelSmall,
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(10),
                    border: const Border.fromBorderSide(
                      BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedDriver,
                      isExpanded: true,
                      items: driverOptions
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

                const SizedBox(height: 12),

                // stripeToken
                Text("Payment token", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: tokenController,
                  decoration: const InputDecoration(
                    hintText: "e.g. tok_visa",
                  ),
                ),

                const SizedBox(height: 12),

                // amount
                Text("Amount", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: "e.g. 100",
                    prefixText: "\$ ",
                  ),
                ),

                const SizedBox(height: 12),

                // account_id
                Text("Account ID", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: accountIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "e.g. 123",
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: هنا مستقبلاً تبعتي POST /api/pay
                          Navigator.pop(context);
                        },
                        child: const Text("Pay now"),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
