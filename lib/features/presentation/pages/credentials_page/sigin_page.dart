//Packages
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:insta_clone/features/presentation/bloc/auth/bloc/auth_bloc.dart";
import "package:insta_clone/features/presentation/bloc/credentails/bloc/credentials_bloc.dart";
import "package:insta_clone/features/presentation/pages/main_screens/main_screen.dart";
import "package:insta_clone/features/presentation/widgets/button_container_wdget.dart";
import "package:insta_clone/features/presentation/widgets/form_container_widget.dart";
import "package:insta_clone/injection_container.dart" as di;

//uitls
import "package:insta_clone/utils/colors.dart";
import "package:insta_clone/utils/global_variables.dart";

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSingingIn = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: BlocConsumer<CredentialsBloc, CredentialsState>(
        bloc: di.sl<CredentialsBloc>(),
        listener: (context, credState) {
          if (credState is CredentialSuccess) {
            context.read<AuthBloc>().add(LogIn());
          }
          if (credState is CredentialFailure) {
            toast("Invalid email and password");
          }
        },
        builder: (context, credState) {
          if (credState is CredentialSuccess) {
            return BlocBuilder(
              bloc: di.sl<AuthBloc>(),
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                }
                return _bodyWidget(screenSize);
              },
            );
          }

          return _bodyWidget(screenSize);
        },
      ),
    );
  }

  _bodyWidget(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Center(
              child: Image.asset(
            "assets/images/insta.png",
            height: screenSize.height * 0.12,
          )),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          FormConatinerField(
            formController: _emailController,
            hintText: "Email",
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          FormConatinerField(
            formController: _passwordController,
            hintText: "Password",
            isPasswordField: true,
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          _isSingingIn == false
              ? ButtonConatinerWidget(
                  color: buttonColor,
                  onTapListener: () {
                    _signInUser()
                        .whenComplete(() => Future.delayed(
                              const Duration(seconds: 1),
                            ))
                        .then((value) => _clear());
                    
                  },
                  buttonName: "SignIn",
                )
              : Container(
                alignment: Alignment.center,
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: buttonColor
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please wait",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
          ButtonConatinerWidget(
            onTapListener: () {
              Navigator.pushNamed(context, PageConst.signUpPage);
            },
            outLineButton: true,
            color: buttonColor,
            buttonName: "Create Account",
          ),
          SizedBox(
            height: screenSize.height * 0.005,
          ),
          Center(
            child: Image.asset(
              "assets/images/meta-black.png",
              color: primaryColor,
              height: screenSize.height * 0.07,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signInUser() async {
    setState(() {
      _isSingingIn = true;
    });
    context.read<CredentialsBloc>().add(
          SignInUser(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _isSingingIn = false;
    });
  }
}
