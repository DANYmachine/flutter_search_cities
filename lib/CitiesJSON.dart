import 'package:flutter/cupertino.dart';

class CitiesJSON {
  num id;
  String name;
  String state;
  String country;
  double lon;
  double lat;

  CitiesJSON(
    this.id,
    this.name,
    this.state,
    this.country,
    this.lon,
    this.lat,
  );

  @override
  String toString() {
    // TODO: implement toString
    return 'Name: $name, State: $state, Country: $country';
  }
}
