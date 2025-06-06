import 'package:go_router/go_router.dart';
import 'package:money_monday/views/loading_page.dart';
import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginPage()),
    GoRoute(path: '/loading', builder: (context, state) => LoadingPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
  ],
);
