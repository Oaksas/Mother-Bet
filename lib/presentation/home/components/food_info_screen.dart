import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mother_bet/bloc/foodBloc/bloc.dart';
import 'package:mother_bet/dataProvider/foods_data_provider.dart';
import 'package:mother_bet/models/food.dart';
import 'package:mother_bet/presentation/food_app_theme.dart';
import 'package:mother_bet/repository/foods_repository.dart';
import 'package:mother_bet/shared_preferences.dart';

class FoodInfoScreen extends StatefulWidget {
  final Food food;
  FoodInfoScreen(this.food);
  static final String routeName = "/foodDetail";

  @override
  _FoodInfoScreenState createState() => _FoodInfoScreenState(food);
}

class _FoodInfoScreenState extends State<FoodInfoScreen>
    with TickerProviderStateMixin {
  final Food food;

  double _rate = 1.0;
  int user = 4;

  TextEditingController _comment = TextEditingController();

  _FoodInfoScreenState(this.food);
  final double infoHeight = 700.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController!.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  final FoodsRepository foodsRepository = FoodsRepository(FoodsDataProvider());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: foodsRepository,
      child: BlocProvider(
        create: (context) =>
            FoodsBloc(foodsRepository)..add(GetFood(food.foodId)),
        child: Container(
          color: FoodAppTheme.nearlyWhite,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Image(image: AssetImage("assets/${food.image}")),
                    ),
                  ],
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: FoodAppTheme.nearlyWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FoodAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, left: 18, right: 16),
                                child: Text(
                                  food.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: FoodAppTheme.darkerText,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 8, top: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Price: \$${food.price}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: FoodAppTheme.nearlyBlue,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            food.mother.name,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 22,
                                              letterSpacing: 0.27,
                                              color: FoodAppTheme.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      'Ingredients',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.25,
                                        color: FoodAppTheme.darkerText,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '${food.ingredient}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: FoodAppTheme.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 270,
                              ),
                              Center(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.bookmark),
                                  label: const Text('Order'),
                                  onPressed: () {
                                    Widget cancelButton = TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget continueButton = TextButton(
                                      child: const Text("Continue"),
                                      onPressed: () {},
                                    );
                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      title: const Text("Accept"),
                                      content: const Text(
                                          "Are You sure you want to order this food?"),
                                      actions: [
                                        cancelButton,
                                        continueButton,
                                      ],
                                    );
                                    // show the dialog
                                    showDialog(
                                        context: context,
                                        builder: (_) => alert,
                                        barrierDismissible: false);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: FoodAppTheme.nearlyBlack,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 20.0 - 20,
                  right: 35,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: CurvedAnimation(
                        parent: animationController!,
                        curve: Curves.fastOutSlowIn),
                    child: Card(
                      color: FoodAppTheme.nearlyBlack,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 8.0,
                      child: Container(
                        width: 30,
                        height: 30,
                        child: const Center(
                          child: Icon(
                            Icons.push_pin,
                            color: FoodAppTheme.nearlyWhite,
                            size: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
