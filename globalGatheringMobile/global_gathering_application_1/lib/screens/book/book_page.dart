import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/event/event_bloc.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:global_gathering_application_1/repository/event/event_repository_impl.dart';
import 'package:global_gathering_application_1/screens/book/booked_page.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';

class BookedTravels extends StatefulWidget {
  final String uuid;
  const BookedTravels({Key? key, required this.uuid});

  @override
  State<BookedTravels> createState() => _BookedTravelsState();
}

class _BookedTravelsState extends State<BookedTravels> {
  late EventRepository eventRepository;

  @override
  void initState() {
    super.initState();
    eventRepository = EventRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EventBloc(eventRepository)..add(DoAssignedEvent(widget.uuid)),
      child: _doRegisterEvent(),
    );
  }
}

Widget _doRegisterEvent() {
  return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
    if (state is AssigEventFetchSucess) {
      return BookedPage();
    } else if (state is GetEventError) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('You are already in this event'),
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
      });
      return HomePage();
    }
    return const Center(child: CircularProgressIndicator());
  });
}
