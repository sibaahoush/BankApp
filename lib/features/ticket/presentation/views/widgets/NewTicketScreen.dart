import 'package:flutter/material.dart';

class NewTicketScreen extends StatelessWidget {
  const NewTicketScreen({super.key});

  static const routename = "newTicket";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final subjectController = TextEditingController();
    final messageController = TextEditingController();

    String selectedCategory = "Technical issue";
    final categories = [
      "Technical issue",
      "Card & payments",
      "Account & profile",
      "Other",
    ];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category", style: theme.textTheme.labelSmall),
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
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return DropdownButton<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      items: categories
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
                        setState(() => selectedCategory = v);
                      },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text("Subject", style: theme.textTheme.labelSmall),
            const SizedBox(height: 4),
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                hintText: "Short title for your issue",
              ),
            ),

            const SizedBox(height: 16),

            Text("Message", style: theme.textTheme.labelSmall),
            const SizedBox(height: 4),
            TextField(
              controller: messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Describe your issue in details...",
              ),
            ),

            const SizedBox(height: 24),

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
                      // TODO: POST create tickets
                    },
                    child: const Text("Submit ticket"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
