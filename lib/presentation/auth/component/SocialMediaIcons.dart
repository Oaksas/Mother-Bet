import 'package:flutter/material.dart';
import 'package:mother_bet/presentation/auth/constants.dart';

class SocialMediaIcons extends StatelessWidget {
  final String? iconSrc;
  final void Function()? pressed;
  const SocialMediaIcons({
    this.iconSrc,
    this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryColor,
          ),
          shape: BoxShape.circle,
        ),
        // child: SvgPicture.asset(
        //   iconSrc,
        //   height: 20,
        //   width: 20,
        // ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: Row(
        children: const [
          LineDivider(),
          Text(
            "OR",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          LineDivider(),
        ],
      ),
    );
  }
}

class LineDivider extends StatelessWidget {
  const LineDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Divider(
        color: kPrimaryColor,
        height: 1.5,
      ),
    );
  }
}
