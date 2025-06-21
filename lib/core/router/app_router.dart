import 'package:go_router/go_router.dart';
import 'package:pgas/presentation/pages/account_page/account_page.dart';
import 'package:pgas/presentation/pages/home_page/home_page.dart';
import 'package:pgas/presentation/pages/log_page/log_page.dart';
import 'package:pgas/presentation/pages/reg_page/reg_page.dart';
import 'package:pgas/presentation/pages/splash_screen/splash_screen.dart';
import 'package:pgas/presentation/pages/start_page/start_page.dart';
import 'package:pgas/presentation/pages/user_info_page/user_info_page.dart';

abstract class AppRouter {
  static final GoRouter router = 
  GoRouter(initialLocation: '/splash_screen', routes: [
    GoRoute(
      path: '/splash_screen', builder: (context, state) => SplashScreensGate()
      ),
      GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/reg',
      builder: (context, state) => const RegPage(),
    ),
      GoRoute(
        path: '/home_page', builder: (context, state) => HomePage(),
        ),
      GoRoute(
        path: '/account_page', builder: (context, state) => AccountPage(),
        ),
      GoRoute(
        path: '/start', builder: (context, state) => StartPage(),
        ),
        GoRoute(
        path: '/user_info', builder: (context, state) => UserInfoPage(),
        )
  ]
  );
}