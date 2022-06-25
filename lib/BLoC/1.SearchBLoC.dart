import 'package:flutter_bloc/flutter_bloc.dart';
import '2.SearchEvent.dart';
import '3.SearchState.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchEmptyState()) {
    on<SearchChangedEvent>((event, emit) {
      emit(SearchChangedState(cities: event.cities));
    });
  }
}
