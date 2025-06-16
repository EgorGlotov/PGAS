import 'package:go_router/go_router.dart';
import 'package:pgas/presentation/pages/home_page/home_page.dart';
import 'package:pgas/presentation/pages/splash_screen/splash_screen.dart';

abstract class AppRouter {
  static final GoRouter router = 
  GoRouter(initialLocation: '/splash_screen', routes: [
    GoRoute(
      path: '/splash_screen', builder: (context, state) => SplashScreen()
      ),
      GoRoute(
        path: '/home_page', builder: (context, state) => HomePage(),
        )
  ]
  );
}