import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mother_bet/models/mother.dart';
import 'package:mother_bet/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;

  SearchBloc(this.searchRepository) : super(SearchInitial());
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchFoods) {
      try {
        final mothers = await searchRepository.searchFoods(event.name);
        yield SearchSuccess(mothers);
      } catch (e) {
        yield SearchFailure(e.toString());
      }
    }
  }
}
