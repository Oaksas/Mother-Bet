import 'package:flutter/material.dart';
import 'package:mother_bet/models/food.dart';
import 'package:mother_bet/presentation/auth/login_screen.dart';
import 'package:mother_bet/presentation/auth/signup.dart';
import 'package:mother_bet/presentation/auth/welcome_page.dart';
import 'package:mother_bet/presentation/home/components/food_info_screen.dart';
import 'package:mother_bet/presentation/home/home.dart';
import 'package:mother_bet/presentation/mapDisplay/map_view.dart';

class Routes {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => const WelcomePage());
    }

// Auth
    if (settings.name == LoginPage.routeName) {
      return MaterialPageRoute(builder: (context) => LoginPage());
    }

    if (settings.name == SignUpPage.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpPage());
    }

    // Bottom Navigation
    if (settings.name == HomeScreen.routeName) {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    }
    if (settings.name == MapScreen.routeName) {
      return MaterialPageRoute(builder: (context) => const MapScreen());
    }

    // Food
    if (settings.name == FoodInfoScreen.routeName) {
      Food food = settings.arguments as Food;
      return MaterialPageRoute(builder: (context) => FoodInfoScreen(food));
    }

    return MaterialPageRoute(builder: (context) => const WelcomePage());
  }
}

class TourArgument {
  final Food tour;
  TourArgument(this.tour);
}
