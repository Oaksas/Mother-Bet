import 'package:flutter/material.dart';
import 'package:mother_bet/models/food.dart';
import 'package:mother_bet/presentation/home/components/food_card.dart';

class PopularFoods extends StatefulWidget {
  const PopularFoods({Key? key}) : super(key: key);

  @override
  _PopularFoodsState createState() => _PopularFoodsState();
}

class _PopularFoodsState extends State<PopularFoods> {
  int currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentSlider = value;
                  });
                },
                controller:
                    PageController(viewportFraction: 0.8, initialPage: 0),
                itemCount: demoFoods.length,
                itemBuilder: (context, index) => FoodCard(demoFoods[index])),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  demoFoods.length, (index) => buildDotNav(index)),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer buildDotNav(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentSlider == index ? 24 : 6,
      decoration: BoxDecoration(
          color: currentSlider == index
              ? const Color(0XFF6A62B7)
              : const Color(0XFF6A62B7).withAlpha(70),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
