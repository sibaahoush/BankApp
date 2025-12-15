abstract class BackendEndPoint {
  static const String url = 'http://10.0.2.2:8000';

  // Auth endpoints
  static const String signIn = '/api/login';
  static const String signUp = '/api/register';
  static const String verifyOtp = '/api/verify-otp';
  static const String resendOtp = '/api/resend-otp';
  static const String signOut = '/api/logout';
  static const String refresh = '/api/refresh';

  // General data endpoints
  static const String accountTypes = '/api/account/types/all';
  static const String accountStatuses = '/api/account/statuses/all';
  static const String roles = '/api/roles/all';

  // Account endpoints
  static const String accounts = '/api/account/all';
  static const String createAccount = '/api/account';
  static const String getAccount = '/api/account'; // + /{id}
  static const String getAccountTree = '/api/account'; // + /{id}/tree
  static const String updateAccount = '/api/account'; // + /{id}
  static const String deleteAccount = '/api/account'; // + /{id}
  static const String closeAccount = '/api/account'; // + /{id}/close

  // Transaction endpoints
  static const String transactions = '/api/transactions/all';
  static const String createTransaction = '/api/transaction';
  static const String createScheduledTransaction = '/api/scheduled-transactions';

  // Payment endpoints
  static const String processWithdraw = '/api/withdraw';
  static const String processPayment = '/api/pay';

  // Ticket endpoints
  static const String tickets = '/api/tickets';
  static const String createTicket = '/api/tickets';
  static const String getTicket = '/api/tickets'; // + /{id}
  static const String replyToTicket = '/api/tickets'; // + /{id}/reply

  // AI endpoints
  static const String aiRecommend = '/api/ai/recommend';
}
