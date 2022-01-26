part of 'foods_bloc.dart';

abstract class FoodsState extends Equatable {
  const FoodsState();

  @override
  List<Object> get props => [];
}

class FoodsInitial extends FoodsState {}

class FoodsOperationSuccess extends FoodsState {
  final Iterable<Food> foods;

  const FoodsOperationSuccess([this.foods = const []]);

  @override
  List<Object> get props => [foods];
}

class FoodsOperationFailure extends FoodsState {
  final String message;

  const FoodsOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class MothersSuccess extends FoodsState {
  final Iterable<Mother> mothers;

  const MothersSuccess([this.mothers = const []]);

  @override
  List<Object> get props => [mothers];
}

class MotherFailure extends FoodsState {
  final String message;

  const MotherFailure(this.message);

  @override
  List<Object> get props => [message];
}

class FoodSuccess extends FoodsState {
  final Food food;

  const FoodSuccess(this.food);

  @override
  List<Object> get props => [food];
}

class FoodFailure extends FoodsState {
  final String message;

  const FoodFailure(this.message);

  @override
  List<Object> get props => [message];
}
