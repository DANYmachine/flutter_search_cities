import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_cities_test/BLoC/1.SearchBLoC.dart';
import 'package:json_cities_test/BLoC/2.SearchEvent.dart';
import 'package:json_cities_test/CitiesJSON.dart';

import 'BLoC/3.SearchState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await readJson();
  log(citiesJson.length.toString());
  runApp(const MyApp());
}

List<CitiesJSON> citiesJson = [];

Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/list.json');
  final data = await jsonDecode(response);

  for (var note in data) {
    citiesJson.add(
      CitiesJSON(
        note['id'],
        note['name'],
        note['state'],
        note['country'],
        note['coord']['lon'],
        note['coord']['lat'],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SearchBloc _bloc;

  var _filtered = <CitiesJSON>[];
  final _searchController = TextEditingController();

  void _search() {
    final query = _searchController.text;

    if (query.isNotEmpty) {
      _filtered = citiesJson.where((CitiesJSON city) {
        return city.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filtered = citiesJson;
    }

    _bloc.add(SearchChangedEvent(cities: _filtered));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _bloc = BlocProvider.of<SearchBloc>(context);
    _bloc.add(SearchChangedEvent(cities: citiesJson));

    _search();
    _searchController.addListener(_search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state is SearchChangedState) {
          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(top: 70),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Text(state.cities[index].id.toString()),
                      title: Text(state.cities[index].name),
                      trailing: Text(
                        '${state.cities[index].lon} ${state.cities[index].lat}',
                      ),
                      subtitle: Text('Country: ${state.cities[index].country}'),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox();
      }),
    );
  }
}

/*
class _MyHomePageState extends State<MyHomePage> {

  

  @override
  void initState() {
    
  }

  @override
  Widget build(BuildContext context) {}
}
*/