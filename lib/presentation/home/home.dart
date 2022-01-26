import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mother_bet/bloc/foodBloc/foods_bloc.dart';
import 'package:mother_bet/dataProvider/foods_data_provider.dart';
import 'package:mother_bet/outExeption.dart';
import 'package:mother_bet/presentation/home/components/drawer.dart';
import 'package:mother_bet/presentation/home/components/food_list_view.dart';
import 'package:mother_bet/presentation/mapDisplay/map_view.dart';
import 'package:mother_bet/repository/foods_repository.dart';

import 'components/populart_foods.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  final double size = 10;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({Key? key}) : super(key: key);

  final FoodsRepository foodsRepository = FoodsRepository(FoodsDataProvider());

  void _getLocationPermission() {
    var location = Location();
    try {
      location.requestPermission();
    } on Exception catch (_) {
      throw AppExc("Location Access Not Granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    _getLocationPermission();

    return RepositoryProvider.value(
      value: foodsRepository,
      child: BlocProvider(
        create: (context) => FoodsBloc(foodsRepository)..add(LoadFoods()),
        child: Scaffold(
          key: scaffoldKey,
          drawer: const Drawer(
            child: MainDrawer(),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Discover",
              style: TextStyle(color: Color(0XFF2C2C2C), fontSize: 25),
            ),
            leading: IconButton(
                icon: const ClipOval(
                  child: Image(
                    image: AssetImage('assets/images/menu.png'),
                  ),
                ),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                }),
            actions: [
              IconButton(
                  icon: const ClipOval(
                    child: Image(
                      image: AssetImage("assets/images/avatar.png"),
                    ),
                  ),
                  onPressed: () {}),
            ],
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: size,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        const PopularFoods(),
                        Flexible(
                          child: topPickedFoods(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              tooltip: 'GoToMap',
              child: const Icon(Icons.map),
              onPressed: () {
                Navigator.of(context).pushNamed(MapScreen.routeName);
              }),
        ),
      ),
    );
  }

  Widget topPickedFoods() {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Top Picked Foods',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: Colors.black,
            ),
          ),
          Flexible(
            child: FoodsListView(),
          )
        ],
      ),
    );
  }
}
