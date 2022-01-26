import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mother_bet/models/food.dart';
import 'package:mother_bet/models/mother.dart';
import 'package:mother_bet/repository/foods_repository.dart';

part 'foods_event.dart';
part 'foods_state.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  FoodsRepository foodsRepository;
  FoodsBloc(this.foodsRepository) : super(FoodsInitial());

  Stream<FoodsState> mapEventToState(FoodsEvent event) async* {
    if (event is LoadFoods) {
      try {
        final foods = await foodsRepository.fetchTopFoods();
        yield FoodsOperationSuccess(foods);
      } catch (e) {
        print(e);
        yield FoodsOperationFailure(e.toString());
      }
    }

    if (event is LoadMothers) {
      try {
        final mothers = await foodsRepository.fetchMothers();
        yield MothersSuccess(mothers);
      } catch (e) {
        print(e);
        yield MotherFailure(e.toString());
      }
    }
    if (event is GetFood) {
      try {
        final mothers =
            await foodsRepository.getFood(event.id);
        yield FoodSuccess(mothers);
      } catch (e) {
        yield FoodFailure(e.toString());
      }
    }
  }
}
