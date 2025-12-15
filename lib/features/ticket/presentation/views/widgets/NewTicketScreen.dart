import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ticket_controller.dart';

class NewTicketScreen extends StatefulWidget {
  const NewTicketScreen({super.key});

  static const routename = "newTicket";

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  final TicketController _controller = Get.find<TicketController>();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedCategory = "Technical issue";
  final _categories = [
    "Technical issue",
    "Card & payments",
    "Account & profile",
    "Other",
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitTicket() async {
    if (!_formKey.currentState!.validate()) return;

    await _controller.createTicket(
      title: _titleController.text.trim(),
      message: _messageController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New ticket"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Category", style: theme.textTheme.labelSmall),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(10),
                  border: const Border.fromBorderSide(
                    BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: _categories
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text(
                              c,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => _selectedCategory = v);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text("Subject", style: theme.textTheme.labelSmall),
              const SizedBox(height: 4),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "Short title for your issue",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              Text("Message", style: theme.textTheme.labelSmall),
              const SizedBox(height: 4),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Describe your issue in details...",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              Obx(() {
                return Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: _controller.isCreatingTicket.value
                            ? null
                            : () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _controller.isCreatingTicket.value
                            ? null
                            : _submitTicket,
                        child: _controller.isCreatingTicket.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text("Submit ticket"),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
