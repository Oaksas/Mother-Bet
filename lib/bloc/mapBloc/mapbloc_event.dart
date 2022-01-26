part of 'mapbloc_bloc.dart';

@immutable
abstract class MapBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMothers extends MapBlocEvent {}

class MapDirectionEvent extends MapBlocEvent {
  final LatLng origin;
  final LatLng destination;

  // Get Directions
  MapDirectionEvent(this.origin, this.destination);

  @override
  List<Object> get props => [origin, destination];
}
