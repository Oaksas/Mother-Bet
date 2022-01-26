part of 'mapbloc_bloc.dart';

@immutable
abstract class MapBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class MapBlocInitial extends MapBlocState {}

class MapDirectionState extends MapBlocState {
  final Directions direction;

  MapDirectionState(this.direction);
  @override
  List<Object> get props => [direction];
}

class MapFailure extends MapBlocState {
  final String txt;

  MapFailure(this.txt);

  @override
  List<Object> get props => [txt];
}

class MothersSuccessState extends MapBlocState {
  final List<Mother> mothers;

  MothersSuccessState(this.mothers);

  @override
  List<Object> get props => [mothers];
}

class MothersFailure extends MapBlocState {
  final String txt;

  MothersFailure(this.txt);
  @override
  List<Object> get props => [txt];
}
