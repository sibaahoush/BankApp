import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/nav_bar/nav_bar_cubit.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: context.watch<NavBarCubit>().currentIndex,
      onTap: (index) {
        context.read<NavBarCubit>().changeIndex(index);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: "Account",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.send_rounded),
          label: "Transactions",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.comment_bank_outlined),
          label: "Chat",
        ),
      ],
    );
  }
}
