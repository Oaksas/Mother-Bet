part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFoods extends SearchEvent {
  final String name;

  const SearchFoods(this.name);
  @override
  List<Object> get props => [name];
}
