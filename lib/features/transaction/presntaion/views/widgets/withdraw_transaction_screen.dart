import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../account/presentation/controllers/account_controller.dart';

class WithdrawTransactionScreen extends StatefulWidget {
  const WithdrawTransactionScreen({super.key});
  static const routename = "WithdrawTransactionScreen";

  @override
  State<WithdrawTransactionScreen> createState() => _WithdrawTransactionScreenState();
}

class _WithdrawTransactionScreenState extends State<WithdrawTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final driverOptions = ["stripe", "braintree"];
  String selectedDriver = "stripe";

  final nonceController = TextEditingController();
  final amountController = TextEditingController();
  final transactionIdController = TextEditingController();

  @override
  void dispose() {
    nonceController.dispose();
    amountController.dispose();
    transactionIdController.dispose();
    super.dispose();
  }

  void _handleWithdraw() {
    if (_formKey.currentState?.validate() ?? false) {
      final controller = Get.find<AccountController>();

      controller.processWithdraw(
        amount: double.parse(amountController.text),
        driver: selectedDriver,
        nonce: nonceController.text,
        transactionId: transactionIdController.text.isNotEmpty
            ? transactionIdController.text
            : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<AccountController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Withdraw")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment Gateway Selection
              Text(
                "Payment Gateway",
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
                  border: const Border.fromBorderSide(
                    BorderSide(color: Color(0xFFE5E7EB), width: 1),
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
                              d == 'stripe' ? 'Stripe' : 'PayPal (Braintree)',
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

              // Nonce Field
              Text("Payment Nonce", style: theme.textTheme.labelSmall),
              const SizedBox(height: 4),
              TextFormField(
                controller: nonceController,
                decoration: const InputDecoration(
                  hintText: "e.g. fake-valid-nonce",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter payment nonce';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Amount Field
              Text("Amount", style: theme.textTheme.labelSmall),
              const SizedBox(height: 4),
              TextFormField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: "e.g. 250",
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

              // Transaction ID (Optional)
              Text(
                "Transaction ID (Optional)",
                style: theme.textTheme.labelSmall,
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: transactionIdController,
                decoration: const InputDecoration(
                  hintText: "e.g. ch_3ScsqXE5xIUnP1kr1Q4uLDPF",
                ),
              ),

              const Spacer(),

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
                      ),
                      onPressed: controller.isProcessingWithdraw.value
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.isProcessingWithdraw.value
                          ? null
                          : _handleWithdraw,
                      child: controller.isProcessingWithdraw.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text("Withdraw now"),
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
