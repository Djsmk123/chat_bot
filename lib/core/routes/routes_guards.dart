import 'package:auto_route/auto_route.dart';
import 'package:chat_with_us/core/routes/routes.gr.dart';
import 'package:chat_with_us/features/auth/data/repo/auth_services.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (AuthService.isAuthenticated) {
      resolver.next(true);
    } else {
      router.popAndPush(const LoginScreen());
    }
  }
}
