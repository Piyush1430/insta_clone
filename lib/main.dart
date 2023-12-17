import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:insta_clone/features/presentation/bloc/auth/bloc/auth_bloc.dart";
import "package:insta_clone/features/presentation/bloc/credentails/bloc/credentials_bloc.dart";
import "package:insta_clone/features/presentation/bloc/user/get_single_user/bloc/get_single_user_bloc.dart";
import "package:insta_clone/features/presentation/bloc/user/user_bloc/user_bloc.dart";
import "package:insta_clone/features/presentation/pages/credentials_page/sigin_page.dart";
import "package:insta_clone/firebase_options.dart";
import "package:insta_clone/injection_container.dart" as di;
import "package:insta_clone/on_generate_route.dart";
import "package:insta_clone/utils/colors.dart";
import "package:insta_clone/utils/global_variables.dart";
import "package:insta_clone/features/presentation/pages/main_screens/main_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) =>
              di.sl<AuthBloc>()..add(AppStarted(context: context)),
        ),
        BlocProvider<CredentialsBloc>(
            create: (_) => di.sl<CredentialsBloc>()),
        BlocProvider<UserBloc>(create: (_) => di.sl<UserBloc>()),
        BlocProvider<GetSingleUserBloc>(
            create: (_) => di.sl<GetSingleUserBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          scaffoldBackgroundColor: screenSize.width < webScreenSize
              ? mobileBackgroundColor
              : webBackgroundColor,
        ),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        routes: {
          "/": (context) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(
                    uid: authState.uid,
                  );
                }
                return const SignInPage();
              },
            );
          },
        },
      ),
    );
  }
}
