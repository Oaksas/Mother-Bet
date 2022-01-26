import 'package:flutter/material.dart';
import 'package:mother_bet/presentation/auth/component/text_field_container.dart';
import 'package:mother_bet/presentation/auth/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController passwordController;

  RoundedPasswordField(this.onChanged, this.passwordController, {Key? key})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      obscureText: hidePassword,
      onChanged: widget.onChanged,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Password is Required';
        } else if (value.length < 6) {
          return 'Password too short';
        }
        return null;
      },
      controller: widget.passwordController,
      decoration: InputDecoration(
          hintText: "Password",
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: TextButton.icon(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            icon: const Icon(Icons.visibility),
            label: Text(""),
          ),
          border: InputBorder.none),
    ));
  }
}
