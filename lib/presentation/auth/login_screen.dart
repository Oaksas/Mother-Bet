import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mother_bet/bloc/authBloc/auth_bloc.dart';
import 'package:mother_bet/presentation/auth/component/bezier_container.dart';
import 'package:mother_bet/presentation/auth/component/roundedBtn.dart';
import 'package:mother_bet/presentation/auth/component/rounded_password_field.dart';
import 'package:mother_bet/presentation/auth/component/text_field_container.dart';
import 'package:mother_bet/presentation/auth/component/title.dart';
import 'package:mother_bet/presentation/auth/constants.dart';
import 'package:mother_bet/presentation/auth/signup.dart';
import 'package:mother_bet/presentation/home/home.dart';
import 'package:mother_bet/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hiddenPassword = true;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SizedBox(
      height: height,
      child: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: const BezierContainer()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    titleName(),
                    const SizedBox(height: 5),
                    TextFieldContainer(child: _emailField()),
                    RoundedPasswordField(
                      null,
                      passwordTextController,
                    ),
                    const SizedBox(height: 10),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (ctx, authState) {
                        if (authState is AuthSuccess) {
                          UserSimplePreferences.setUser(authState.user);

                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        }
                      },
                      builder: (ctx, authState) {
                        Widget buttonChild = RoundedButton(
                          text: "Login",
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          pressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            final authBloc = BlocProvider.of<AuthBloc>(context);

                            authBloc.add(LogInEvent(emailTextController.text,
                                passwordTextController.text));
                          },
                        );
                        if (authState is AuthInProgress) {
                          buttonChild = const CircularProgressIndicator(
                            color: Colors.blue,
                          );
                        }
                        if (authState is AuthError) {
                          try {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(authState.errMsg)));
                          } catch (e) {
                            print(e);
                          }
                        }

                        return Container(child: buttonChild);
                      },
                    ),
                    SizedBox(height: height * .03),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 30, left: 0, child: _backButton()),
          ],
        ),
      ),
    ));
  }

  Widget _emailField() {
    return TextFormField(
      controller: emailTextController,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.email,
          color: kPrimaryColor,
        ),
        hintText: "Email",
        border: InputBorder.none,
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
    );
  }
}
