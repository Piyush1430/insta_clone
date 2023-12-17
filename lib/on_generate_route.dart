import 'package:flutter/material.dart';
import 'package:insta_clone/features/presentation/pages/credentials_page/sigin_page.dart';
import 'package:insta_clone/features/presentation/pages/credentials_page/signup_page.dart';
import 'package:insta_clone/utils/global_variables.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings routeSettings) {
  //  final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case PageConst.signInPage:
        {
          return routeBuilder(const SignInPage());
        }
      case PageConst.signUpPage:
        {
          return routeBuilder(const SignUpPage());
        }

      default:
        {
          const NoPageFound();
        }
    }
    return null;
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}
