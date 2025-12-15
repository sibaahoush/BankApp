import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../account/presentation/controllers/account_controller.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key});
  static const routename = "newTransaction";

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  String selectedType = "deposit";
  String? selectedAccountNumber;

  final types = ["deposit", "withdraw"];

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AccountController controller = Get.find<AccountController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("New transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Selection
              Text("Select Account", style: theme.textTheme.labelSmall),
              const SizedBox(height: 4),
              Obx(() {
                final accounts = controller.accounts;

                if (accounts.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Text(
                      'No accounts available',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      value: selectedAccountNumber,
                      isExpanded: true,
                      hint: Text(
                        'Select an account',
                        style: theme.textTheme.bodySmall,
                      ),
                      items: accounts.map((account) {
                        return DropdownMenuItem(
                          value: account.number,
                          child: Text(
                            '${account.type} - ${account.number}',
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedAccountNumber = value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an account';
                        }
                        return null;
                      },
                    ),
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Amount
              Text("Amount", style: theme.textTheme.labelSmall),
              const SizedBox(height: 4),
              TextFormField(
                controller: amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "e.g. 200",
                  prefixText: "\$ ",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Transaction Type
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
                              t.toUpperCase(),
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

              // Action Buttons
              Obx(() => Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: controller.isCreatingTransaction.value
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.isCreatingTransaction.value
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                controller.createTransaction(
                                  accountId: selectedAccountNumber!,
                                  amount: double.parse(amountController.text),
                                  type: selectedType,
                                );
                              }
                            },
                      child: controller.isCreatingTransaction.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text("Submit"),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
