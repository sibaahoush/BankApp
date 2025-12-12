import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se3/features/home/home_view.dart';
import '../../../account/presentation/views/account_view.dart';
import '../../../ai/presentation/views/ai_bot_view.dart';
import '../../../ticket/presentation/views/ticket_view.dart';
import '../../../transaction/presntaion/views/transaction_view.dart';
import '../cubits/nav_bar/nav_bar_cubit.dart';
import 'widgets/CustomNavBar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static const routename = "main";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          return Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            //   child: const Icon(Icons.add),
            // ),
            appBar: AppBar(
              title: Text(["Home", "Accounts", "Chat", "Transactions",'Tickets'][state]),
            ),
            bottomNavigationBar: CustomNavBar(),
            body:
                [
                  HomeView(),
                  AccountView(),
                  TransactionView(),
                  ChatbotView(),
                      TicketView(),
                ][state],
          );
        },
      ),
    );
  }
}
