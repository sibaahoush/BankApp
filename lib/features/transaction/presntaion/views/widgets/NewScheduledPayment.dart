import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../account/presentation/controllers/account_controller.dart';

class NewScheduledPaymentScreen extends StatefulWidget {
  const NewScheduledPaymentScreen({super.key});
  static const routename = "newScheduledPayment";

  @override
  State<NewScheduledPaymentScreen> createState() => _NewScheduledPaymentScreenState();
}

class _NewScheduledPaymentScreenState extends State<NewScheduledPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final nextRunController = TextEditingController();
  final relatedAccountIdController = TextEditingController();

  String? selectedAccountNumber;
  String selectedType = "deposit";
  String selectedFrequency = "monthly";
  DateTime? selectedDateTime;

  final types = ["deposit", "withdraw"];
  final frequencies = ["daily", "weekly", "monthly", "yearly"];

  @override
  void dispose() {
    amountController.dispose();
    nextRunController.dispose();
    relatedAccountIdController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
          nextRunController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AccountController controller = Get.find<AccountController>();

    return Scaffold(
      appBar: AppBar(title: const Text("New scheduled transaction")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
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
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: "e.g. 11000",
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

              // Type
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

              // Frequency
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

              // Next Run DateTime
              Text(
                "Next run (date & time)",
                style: theme.textTheme.labelSmall,
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: nextRunController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: "2025-12-08 08:10:00",
                  prefixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                ),
                onTap: _selectDateTime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select date and time';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Account Related ID (Optional)
              Text("Account related ID (Optional)", style: theme.textTheme.labelSmall),
              const SizedBox(height: 4),
              TextFormField(
                controller: relatedAccountIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "e.g. 321"),
              ),

              const SizedBox(height: 200),

              // Action Buttons
              Obx(() => Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.primary,
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: controller.isCreatingScheduledTransaction.value
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.isCreatingScheduledTransaction.value
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                controller.createScheduledTransaction(
                                  accountId: selectedAccountNumber!,
                                  amount: double.parse(amountController.text),
                                  type: selectedType,
                                  frequency: selectedFrequency,
                                  nextRun: nextRunController.text,
                                  accountRelatedId: relatedAccountIdController.text.isNotEmpty
                                      ? relatedAccountIdController.text
                                      : null,
                                );
                              }
                            },
                      child: controller.isCreatingScheduledTransaction.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text("Create"),
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
