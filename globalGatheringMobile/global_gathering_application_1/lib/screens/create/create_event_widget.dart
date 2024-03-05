import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/event/event_bloc.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository_impl.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:global_gathering_application_1/repository/event/event_repository_impl.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:global_gathering_application_1/bloc/comment/comment_bloc.dart';

class CreateEventWidget extends StatefulWidget {
  const CreateEventWidget({Key? key}) : super(key: key);

  @override
  State<CreateEventWidget> createState() => _CreateCommentWidgetState();
}

class _CreateCommentWidgetState extends State<CreateEventWidget> {
  final _formEvent = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final descripcionTextController = TextEditingController();
  final urlTextController = TextEditingController();
  final latitudeTextController = TextEditingController();
  final longitudeTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final ciudadTextController = TextEditingController();

  late EventRepository eventRepository;
  late EventBloc _eventBloc;

  @override
  void initState() {
    eventRepository = EventRepositoryImpl();
    _eventBloc = EventBloc(eventRepository);
    super.initState();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    descripcionTextController.dispose();
    urlTextController.dispose();
    latitudeTextController.dispose();
    longitudeTextController.dispose();
    priceTextController.dispose();
    ciudadTextController.dispose();
    _eventBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      BlocProvider.value(
        value: _eventBloc,
        child: Padding(
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
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
                return Center(child: _buildEventForm());
              },
              listener: (BuildContext context, EventState state) {}),
        ),
      )
    ]);
  }

  _buildEventForm() {
    nameTextController.text = 'Paseo a Caballo por Triana';
    descripcionTextController.text =
        'Paseo por los encatandores callejones de Triana';
    urlTextController.text =
        'https://www.diariodesevilla.es/2020/09/08/sevilla/parada-caballo-Archivo-Indias-Sevilla_1499560215_125430247_1200x675.jpg';
    ciudadTextController.text = 'Sevilla';
    latitudeTextController.text = '37.3955175804586';
    longitudeTextController.text = '-6.012685443168737';
    priceTextController.text = '25';
    return Form(
      key: _formEvent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Information',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameTextController,
              decoration: const InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
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
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
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
              decoration: const InputDecoration(
                labelText: 'Image url',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the image url';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: ciudadTextController,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the city';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: latitudeTextController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Latitude',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the latitude';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: longitudeTextController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Longitude',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the longitude';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: priceTextController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the price';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formEvent.currentState!.validate()) {
                  final double latitude =
                      double.tryParse(latitudeTextController.text) ?? 0.0;
                  final double longitude =
                      double.tryParse(longitudeTextController.text) ?? 0.0;
                  final double price =
                      double.tryParse(priceTextController.text) ?? 0.0;

                  _eventBloc.add(
                    DoCreateEvent(
                      nameTextController.text,
                      descripcionTextController.text,
                      urlTextController.text,
                      latitude,
                      longitude,
                      price,
                      ciudadTextController.text,
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
}
