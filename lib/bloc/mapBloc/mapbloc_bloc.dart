import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:mother_bet/models/directions.dart';
import 'package:mother_bet/models/mother.dart';
import 'package:mother_bet/repository/map_repository.dart';

part 'mapbloc_event.dart';
part 'mapbloc_state.dart';

class MapBloc extends Bloc<MapBlocEvent, MapBlocState> {
  final DirectionsRepository directionsRepository;

  MapBloc(this.directionsRepository) : super(MapBlocInitial());

  @override
  Stream<MapBlocState> mapEventToState(MapBlocEvent event) async* {
    if (event is MapDirectionEvent) {
      try {
        final direction = await directionsRepository.getDirections(
            event.origin, event.destination);
        yield MapDirectionState(direction);
      } catch (e) {
        yield MapFailure(e.toString());
      }
    }

    if (event is LoadMothers) {
      try {
        final mothers = await directionsRepository.fetchAllMothers();
        yield MothersSuccessState(mothers);
      } catch (e) {
        yield MothersFailure(e.toString());
      }
    }
  }
}
