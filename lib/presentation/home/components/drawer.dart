import 'package:flutter/material.dart';
import 'package:mother_bet/models/user.dart';
import 'package:mother_bet/presentation/auth/login_screen.dart';
import 'package:mother_bet/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  static const String routeName = "/drawer";

  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 270,
          child: DrawerHeader(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "nati@gmail.com",
                  style: const TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Text(
                  "0942230327",
                  style: const TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Colors.blue, width: 6.0)))),
                  child: const Text('LogOut'),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.routeName);
                    removeUser();
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                title: const Text(
                  "Settings",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  setUser() async {
    User? user = await UserSimplePreferences.getUser();
    return user!;
  }

  User getUser() {
    return setUser();
  }

  removeUser() async {
    await UserSimplePreferences.removeUser();
  }
}
