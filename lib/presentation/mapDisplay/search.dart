import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mother_bet/bloc/foodBloc/bloc.dart';
import 'package:mother_bet/bloc/search/bloc.dart';
import 'package:mother_bet/dataProvider/search_data_provider.dart';
import 'package:mother_bet/models/mother.dart';
import 'package:mother_bet/repository/search_repository.dart';

class DataSearch extends SearchDelegate<String> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(9.037721, 38.762686),
    zoom: 18,
  );

  Set<Marker> markers = HashSet<Marker>();
  late GoogleMapController _mapController;
  final SearchRepository searchRepository =
      SearchRepository(SearchDataProvider());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    return RepositoryProvider.value(
      value: searchRepository,
      child: BlocProvider(
        create: (context) =>
            SearchBloc(searchRepository)..add(SearchFoods(query)),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchSuccess) {
              final mothers = state.mothers;
              mothers.forEach((mother) => {
                    markers.add(
                      Marker(
                        markerId: MarkerId(mother.motherId),
                        position: LatLng(
                            mother.location.coordinates[0],
                            mother
                                .location.coordinates[1]), //position of marker
                        infoWindow: InfoWindow(
                          title: mother.name,
                          snippet: mother.motto,
                        ),
                        icon: BitmapDescriptor.defaultMarker,
                        onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(
                                maxChildSize: 0.5,
                                minChildSize: 0.1,
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: _list(mother, context),
                                  );
                                },
                              );
                            }),
                      ),
                    )
                  });
              return GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                markers: markers,
              );
            }
            if (state is SearchFailure) {
              return const Center(child: Text("No Result Found"));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final lst =
        query.isEmpty ? recent : all.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: lst.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.food_bank),
            title: RichText(
              text: TextSpan(
                text: lst[index].substring(0, query.length),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: lst[index].substring(query.length),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            onTap: () {
              print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
              showResults(context);
            },
          );
        });
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Widget _list(Mother mother, BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(mother.name),
          onTap: () {
            Navigator.pop(ctx);
          },
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          title: Text(mother.phone),
          onTap: () {
            Navigator.pop(ctx);
          },
        ),
        ListTile(
          leading: const Icon(Icons.map),
          title: Text("Lat: " +
              mother.location.coordinates[0].toString() +
              " - Long: " +
              mother.location.coordinates[1].toString()),
          onTap: () {
            Navigator.pop(ctx);
          },
        ),
        ListTile(
          leading: const Icon(Icons.watch),
          title: const Text("Open"),
          onTap: () {
            Navigator.pop(ctx);
          },
        ),
      ],
    );
  }

  final recent = ["Shiro", "Doro", "Misir", "Egg"];
  final all = [
    "Shiro",
    "Doro",
    "Misir",
    "Egg",
    "Merek",
    "Enjera",
    "Firfir",
    "Beyaynet",
    "Pasta"
  ];
}
