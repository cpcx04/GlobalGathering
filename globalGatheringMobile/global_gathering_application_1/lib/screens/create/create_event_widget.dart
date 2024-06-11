import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:global_gathering_application_1/bloc/event/event_bloc.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:global_gathering_application_1/repository/event/event_repository_impl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CreateEventWidget extends StatefulWidget {
  const CreateEventWidget({Key? key}) : super(key: key);

  @override
  State<CreateEventWidget> createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  final _formEvent = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final descripcionTextController = TextEditingController();
  final urlTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final ciudadTextController = TextEditingController();

  late EventRepository eventRepository;
  late EventBloc _eventBloc;

  // Variables para el mapa
  Completer<GoogleMapController> _controller = Completer();
  late LatLng _selectedPosition;
  Set<Marker> _markers = {};

  // Variables para la fecha
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    eventRepository = EventRepositoryImpl();
    _eventBloc = EventBloc(eventRepository);
    _selectedPosition =
        LatLng(37.3955175804586, -6.012685443168737); // Coordenadas iniciales
    super.initState();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    descripcionTextController.dispose();
    urlTextController.dispose();
    priceTextController.dispose();
    ciudadTextController.dispose();
    _eventBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _eventBloc,
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<EventBloc, EventState>(
                buildWhen: (context, state) {
                  return state is EventInitial ||
                      state is CreateEventSucess ||
                      state is GetEventError ||
                      state is GetEventFetchLoading;
                },
                builder: (context, state) {
                  if (state is CreateEventSucess) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    });
                  } else if (state is GetEventError) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('The event cant be created'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (state is GetEventFetchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _buildEventForm();
                },
                listener: (BuildContext context, EventState state) {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventForm() {
    return Form(
      key: _formEvent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameTextController,
              decoration: InputDecoration(
                labelText: 'Event Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the event name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: descripcionTextController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the event description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: urlTextController,
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the image URL';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Precio y Ciudad en la misma línea
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Precio
                      TextFormField(
                        controller: priceTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Price',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the price';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ciudad
                      TextFormField(
                        controller: ciudadTextController,
                        decoration: InputDecoration(
                          labelText: 'City',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the city';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Selector de fecha
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 20, 12, 71), // Color de fondo personalizado
                    ),
                    child: Text(
                      'Select Date',
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Espacio entre el botón y el texto
                  Expanded(
                    child: Text(
                      'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                      style: GoogleFonts.manrope(),
                      textAlign: TextAlign.end, // Alinear el texto a la derecha
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Mapa para seleccionar la ubicación
            Container(
              height: 300,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _selectedPosition,
                  zoom: 15,
                ),
                onTap: _selectLocation,
                markers: _markers,
              ),
            ),
            const SizedBox(height: 16),
            // Botón para crear el evento
            ElevatedButton(
              onPressed: () {
                if (_formEvent.currentState!.validate()) {
                  final double price =
                      double.tryParse(priceTextController.text) ?? 0.0;

                  _eventBloc.add(
                    DoCreateEvent(
                      nameTextController.text,
                      descripcionTextController.text,
                      urlTextController.text,
                      _selectedPosition.latitude,
                      _selectedPosition.longitude,
                      price,
                      ciudadTextController.text,
                      _selectedDate, // Pasar la fecha seleccionada
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 20, 12, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Create Event',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _selectedPosition = position;
      _markers = {Marker(markerId: MarkerId('selected'), position: position)};
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    if (_selectedPosition != null) {
      setState(() {
        _markers = {
          Marker(markerId: MarkerId('selected'), position: _selectedPosition)
        };
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}
