//Packages
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:insta_clone/features/domain/entities/user/user_entity.dart";
import "package:insta_clone/features/presentation/bloc/auth/bloc/auth_bloc.dart";
import "package:insta_clone/features/presentation/bloc/credentails/bloc/credentials_bloc.dart";
import "package:insta_clone/features/presentation/pages/main_screens/main_screen.dart";
import "package:insta_clone/features/presentation/widgets/button_container_wdget.dart";
import "package:insta_clone/features/presentation/widgets/form_container_widget.dart";
import "package:flutter_svg/flutter_svg.dart";

//uitls
import "package:insta_clone/utils/colors.dart";
import "package:insta_clone/utils/global_variables.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emialController = TextEditingController();
  final _passwordController = TextEditingController();

  final _userNameController = TextEditingController();

  final _bioController = TextEditingController();

  bool _isSingingUp = false;
  @override
  void dispose() {
    _emialController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: primaryColor,
          ),
        ),
      ),
      body: BlocConsumer<CredentialsBloc, CredentialsState>(
        listener: (context, credState) {
          if (credState is CredentialSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LogIn());
          }
          if (credState is CredentialFailure) {
            toast("Invalid Email and password");
          }
        },
        builder: (context, credState) {
          if (credState is CredentialSuccess) {
            return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return MainScreen(uid: authState.uid);
              }
              return bodyWidget(screenSize);
            });
          }
          return bodyWidget(screenSize);
        },
      ),
    );
  }

  bodyWidget(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                height: 60,
              ),
              SizedBox(width: screenSize.width * 0.03),
              Center(
                  child: Image.asset(
                "assets/images/insta.png",
                height: screenSize.height * 0.07,
              )),
            ],
          ),
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 60,
              backgroundImage:
                  const AssetImage("assets/images/profile_default.png"),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: buttonColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          FormConatinerField(
            formController: _userNameController,
            hintText: "Name",
            inputType: TextInputType.name,
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          FormConatinerField(
            formController: _emialController,
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
            inputType: TextInputType.visiblePassword,
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          FormConatinerField(
            formController: _bioController,
            hintText: "bio",
            inputType: TextInputType.multiline,
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          _isSingingUp == false
              ? ButtonConatinerWidget(
                  color: buttonColor,
                  onTapListener: () {
                    _signUpUser().whenComplete(() => _clear());
                  },
                  buttonName: "Sign Up",
                )
              : Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
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

  Future<void> _signUpUser() async {
    setState(() {
      _isSingingUp = true;
    });
    BlocProvider.of<CredentialsBloc>(context).add(
      SignUpUser(
        user: UserEntity(
          userName: _userNameController.text.trim(),
          email: _emialController.text.trim(),
          password: _passwordController.text.trim(),
          bio: _bioController.text.trim(),
          followers: const [],
          following: const [],
          name: "",
          profileUrl: "",
          totalFollowers: 0,
          totalFollowing: 0,
          totalPosts: 0,
          website: "",
        ),
      ),
    );
  }

  _clear() {
    setState(() {
      _userNameController.clear();
      _emialController.clear();
      _passwordController.clear();
      _bioController.clear();
      _isSingingUp = false;
    });
  }
}
