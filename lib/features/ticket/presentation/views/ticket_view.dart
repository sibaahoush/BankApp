import 'package:flutter/material.dart';
import 'package:se3/features/ticket/presentation/views/widgets/ticket_view_body.dart';

import 'widgets/NewTicketScreen.dart';

class TicketView extends StatelessWidget {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, NewTicketScreen.routename);
          // TODO: Navigator.push to NewTicketScreen
        },
        icon: const Icon(Icons.add),
        label: const Text("New ticket"),
      ),
      body: TicketViewBody(),
    );
  }
}
