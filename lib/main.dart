import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mother_bet/bloc/authBloc/auth_bloc.dart';

import 'package:mother_bet/bloc/foodBloc/foods_bloc.dart';
import 'package:mother_bet/dataProvider/auth_data_provider.dart';
import 'package:mother_bet/dataProvider/foods_data_provider.dart';
import 'package:mother_bet/models/user.dart';
import 'package:mother_bet/repository/auth_repository.dart';
import 'package:mother_bet/repository/foods_repository.dart';

import 'package:mother_bet/routes.dart';
import 'package:mother_bet/shared_preferences.dart';

import 'presentation/home/home.dart';

Future main() async {
  User? user;
  try {
    user = await UserSimplePreferences.getUser();
  } catch (ex) {
    user = null;
  }
  runApp(MyApp(user));
}

final authRepo = AuthRepository(AuthDataProvider());
final foodsRepo = FoodsRepository(FoodsDataProvider());

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp(this.user, {Key? key}) : super(key: key);

  initRoute() {
    return _getUser();
  }

  String _getUser() {
    if (user == null) {
      return HomeScreen.routeName;
    } else {
      return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => AuthBloc(authRepo)),
        BlocProvider(create: (ctx) => FoodsBloc(foodsRepo)),
      ],
      child: MaterialApp(
        title: 'Mother Bet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        initialRoute: initRoute(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
