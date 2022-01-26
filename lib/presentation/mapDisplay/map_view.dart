import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mother_bet/bloc/foodBloc/foods_bloc.dart';
import 'package:mother_bet/dataProvider/foods_data_provider.dart';
import 'package:mother_bet/models/mother.dart';
import 'package:mother_bet/presentation/home/components/drawer.dart';
import 'package:mother_bet/presentation/mapDisplay/search.dart';
import 'package:mother_bet/repository/foods_repository.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/search';

  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(9.037721, 38.762686),
    zoom: 16,
  );

  Location location = Location();
  late GoogleMapController _mapController;

  Set<Marker> markers = HashSet<Marker>();

  final FoodsRepository foodsRepository = FoodsRepository(FoodsDataProvider());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: foodsRepository,
      child: BlocProvider(
        create: (context) => FoodsBloc(foodsRepository)..add(LoadMothers()),
        child: Scaffold(
          key: scaffoldKey,
          drawer: const Drawer(
            child: MainDrawer(),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Maps",
              style: TextStyle(color: Color(0XFF2C2C2C), fontSize: 25),
            ),
            leading: IconButton(
                icon: const ClipOval(
                  child: Image(
                    image: AssetImage('assets/images/menu.png'),
                  ),
                ),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                }),
            actions: [
              TextButton(
                onPressed: () =>
                    showSearch(context: context, delegate: DataSearch()),
                child: const Icon(Icons.search),
              ),
            ],
          ),
          body: BlocBuilder<FoodsBloc, FoodsState>(
            builder: (context, state) {
              if (state is MothersSuccess) {
                final mothers = state.mothers;
                mothers.forEach((mother) => {
                      markers.add(
                        Marker(
                          markerId: MarkerId(mother.motherId),
                          position: LatLng(
                              mother.location.coordinates[0],
                              mother.location
                                  .coordinates[1]), //position of marker
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
                                      child: _list(mother),
                                    );
                                  },
                                );
                              }),
                        ),
                      )
                    });
                return GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                  markers: markers,
                );
              }
              if (state is MotherFailure) {
                return Text(state.message);
              }

              return GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                zoomControlsEnabled: true,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                markers: {
                  Marker(
                    markerId: const MarkerId('origin'),
                    infoWindow: const InfoWindow(title: 'Origin'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                    position: const LatLng(8.9806, 38.7578),
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
                                // child: _list(),
                              );
                            },
                          );
                        }),
                  )
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.black,
            onPressed: () => _mapController.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition)),
            child: const Icon(Icons.center_focus_strong),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        ),
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  Widget _list(Mother mother) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(mother.name),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          title: Text(mother.phone),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.map),
          title: Text("Lat: " +
              mother.location.coordinates[0].toString() +
              " - Long: " +
              mother.location.coordinates[1].toString()),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.watch),
          title: const Text("Open"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
