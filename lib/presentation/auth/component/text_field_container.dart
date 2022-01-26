import 'package:flutter/material.dart';
import 'package:mother_bet/presentation/auth/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  const RoundedInputField(this.hintText, this.controller, this.icon,
      {this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Username is required";
        }
        return null;
      },
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: kPrimaryColor,
        ),
        hintText: hintText,
        border: InputBorder.none,
      ),
    ));
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  const TextFieldContainer({this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
