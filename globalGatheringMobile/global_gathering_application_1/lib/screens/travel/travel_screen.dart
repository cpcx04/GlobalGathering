import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/event/event_bloc.dart';
import 'package:global_gathering_application_1/model/reponse/event_response.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:global_gathering_application_1/repository/event/event_repository_impl.dart';
import 'package:global_gathering_application_1/screens/book/booked_page.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:global_gathering_application_1/screens/travel/info_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';

class TravelPage extends StatefulWidget {
  final double latitud;
  final double longitud;
  const TravelPage({Key? key, required this.latitud, required this.longitud})
      : super(key: key);

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  late EventRepository eventRepository;
  List<EventResponse> events = [];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _getInitialCameraPosition(
      double latitud, double longitud) {
    return CameraPosition(
      target: LatLng(latitud, longitud),
      zoom: 15,
    );
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), "assets/icons/marker.png")
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  Set<Marker> _createMarkers(List<EventResponse> events) {
    return Set<Marker>.from(events.map((event) {
      LatLng position = LatLng(event.latitud!, event.longitud!);
      return Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: markerIcon,
        infoWindow: InfoWindow(
          title: event.name,
          snippet: '${event.price} €',
          onTap: () {
            _showInfoDialog(event);
          },
        ),
      );
    }));
  }

  void _showInfoDialog(EventResponse event) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomInfoWindowContent(
                  eventName: event.name!,
                  eventPrice: '${event.price} ',
                  imageUrl: event.url!,
                  descripcion: event.descripcion!,
                  date: event.date!,
                  id: event.id!,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    addCustomIcon();
    super.initState();
    eventRepository = EventRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EventBloc(eventRepository)..add(DoGetEventEvent('events')),
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is GetEventFetchSucess) {
            events = state.event;
            return Scaffold(
              extendBody: true,
              body: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.terrain,
                    initialCameraPosition: _getInitialCameraPosition(
                        widget.latitud, widget.longitud),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: _createMarkers(events),
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    compassEnabled: true,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.076,
                        left: MediaQuery.of(context).size.width * 0.076,
                        right: MediaQuery.of(context).size.width * 0.076),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.transparent,
                shape: const CircularNotchedRectangle(),
                elevation: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color.fromARGB(255, 20, 12, 71),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          icon: const Icon(Icons.home),
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.travel_explore),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.video_collection_rounded),
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookedPage()),
                            );
                          },
                          icon: const Icon(Icons.person),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
              floatingActionButton: FloatingActionButton(
                clipBehavior: Clip.antiAlias,
                backgroundColor: const Color.fromARGB(255, 20, 12, 71),
                onPressed: () {},
                child: const Icon(Icons.add, color: Colors.white, size: 25),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
