import 'package:json_cities_test/CitiesJSON.dart';

abstract class SearchState {}

class SearchEmptyState extends SearchState {}

class SearchChangedState extends SearchState {
  List<CitiesJSON> cities;
  SearchChangedState({required this.cities});
}
