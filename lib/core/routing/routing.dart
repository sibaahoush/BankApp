
import 'package:flutter/material.dart';

import '../../features/account/presentation/views/account_details_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/main/presntation/views/main_view.dart';
import '../../features/auth/presentation/views/sign_in_view.dart';
import '../../features/auth/presentation/views/verf_code_view.dart';
import '../../features/splash/splash_view.dart';
import '../../features/ticket/presentation/views/widgets/NewTicketScreen.dart';
import '../../features/ticket/presentation/views/widgets/TicketDetailsScreen.dart';
import '../../features/transaction/presntaion/views/widgets/NewScheduledPayment.dart';
import '../../features/transaction/presntaion/views/widgets/NewTransaction.dart';
import '../../features/transaction/presntaion/views/widgets/withdraw_transaction_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routename:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case SignInView.routename:
      return MaterialPageRoute(builder: (_) => const SignInView());
    case SignUpView.routename:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    case VerfCodeView.routename:
      return MaterialPageRoute(builder: (_) => const VerfCodeView());
    case MainView.routename:
      return MaterialPageRoute(builder: (_) => const MainView());
      case AccountDetailsView.routename:
      return MaterialPageRoute(
        builder: (_) => const AccountDetailsView(),
        settings: settings,
      );
       case NewTransactionScreen.routename:
      return MaterialPageRoute(builder: (_) => const NewTransactionScreen());
       case NewScheduledPaymentScreen.routename:
      return MaterialPageRoute(builder: (_) => const NewScheduledPaymentScreen());
       case WithdrawTransactionScreen.routename:
      return MaterialPageRoute(builder: (_) => const WithdrawTransactionScreen());
 case TicketDetailsScreen.routename:
      return MaterialPageRoute(
        builder: (_) => const TicketDetailsScreen(),
        settings: settings,
      );
 case NewTicketScreen.routename:
      return MaterialPageRoute(builder: (_) => const NewTicketScreen());

    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
