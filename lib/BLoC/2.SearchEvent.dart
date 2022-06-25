import 'package:json_cities_test/CitiesJSON.dart';

abstract class SearchEvent {}

class SearchChangedEvent extends SearchEvent {
  List<CitiesJSON> cities;
  SearchChangedEvent({required this.cities});
}
