import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../account/presentation/controllers/account_controller.dart';

void showPayBottomSheet(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final driverOptions = ["stripe", "braintree"];
  String selectedDriver = "stripe";
  String? selectedAccountNumber;

  final stripeTokenController = TextEditingController();
  final amountController = TextEditingController();

  final AccountController controller = Get.find<AccountController>();

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
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
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

                  // Payment Gateway
                  Text(
                    "Payment Gateway",
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
                                  d == 'stripe' ? 'Stripe' : 'Braintree (PayPal)',
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

                  // Payment Token/Nonce
                  Text(
                    selectedDriver == 'stripe' ? "Stripe Token" : "Payment Nonce",
                    style: theme.textTheme.labelSmall,
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: stripeTokenController,
                    decoration: InputDecoration(
                      hintText: selectedDriver == 'stripe'
                          ? "e.g. tok_visa"
                          : "e.g. fake-valid-nonce",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return selectedDriver == 'stripe'
                            ? 'Please enter stripe token'
                            : 'Please enter payment nonce';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // Amount
                  Text("Amount", style: theme.textTheme.labelSmall),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      hintText: "e.g. 100",
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

                  const SizedBox(height: 12),

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
                          border: const Border.fromBorderSide(
                            BorderSide(color: Color(0xFFE5E7EB)),
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
                      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      // decoration: BoxDecoration(
                      //   color: theme.inputDecorationTheme.fillColor,
                      //   borderRadius: BorderRadius.circular(10),
                      //   border: const Border.fromBorderSide(
                      //     BorderSide(color: Color(0xFFE5E7EB)),
                      //   ),
                      // ),
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

                  const SizedBox(height: 20),

                  Obx(() => Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: controller.isProcessingPayment.value
                              ? null
                              : () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isProcessingPayment.value
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    controller.processPayment(
                                      amount: double.parse(amountController.text),
                                      driver: selectedDriver,
                                      stripeToken: stripeTokenController.text,
                                      accountId: selectedAccountNumber!,
                                    );
                                  }
                                },
                          child: controller.isProcessingPayment.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text("Pay now"),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
