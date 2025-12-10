import 'package:flutter/material.dart';

class NewTransactionScreen extends StatelessWidget {
  const NewTransactionScreen({super.key});
 static const routename = "newTransaction";
  @override
  Widget build(BuildContext context) {
    final accountIdController = TextEditingController();
    final amountController = TextEditingController();
    String selectedType = "deposit";

    final types = ["deposit", "withdraw", "transfer"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("New transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Account ID", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: accountIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "e.g. 123",
                  ),
                ),

                const SizedBox(height: 16),

                Text("Amount", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: "e.g. 200",
                    prefixText: "\$ ",
                  ),
                ),

                const SizedBox(height: 16),

                Text("Transaction type", style: theme.textTheme.labelSmall),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedType,
                      isExpanded: true,
                      items: types
                          .map(
                            (t) => DropdownMenuItem(
                              value: t,
                              child: Text(
                                t,
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => selectedType = value);
                      },
                    ),
                  ),
                ),

                const Spacer(),

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
                          // هنا منطق الـ POST لاحقاً
                        },
                        child: const Text("Submit"),
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
