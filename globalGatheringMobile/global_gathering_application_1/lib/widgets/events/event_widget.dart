import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/event/event_bloc.dart';
import 'package:global_gathering_application_1/bloc/event/event_bloc.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:global_gathering_application_1/repository/event/event_repository_impl.dart';
import 'package:global_gathering_application_1/widgets/events/event_card.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({super.key});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
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
          EventBloc(eventRepository)..add(DoGetEventEvent('event')),
      child: _eventList(),
    );
  }
}

Widget _eventList() {
  final AutoScrollController _controller = AutoScrollController();
  return BlocBuilder<EventBloc, EventState>(
    builder: (context, state) {
      if (state is GetEventFetchSucess) {
        return Scrollbar(
          controller: _controller,
          thickness: 5.0, // Cambia thickness a hoverThickness
          thumbVisibility: true,
          radius: Radius.circular(12),
          interactive: true,
          child: AutoScrollTag(
            controller: _controller,
            index: 0,
            key: ValueKey(0),
            child: Container(
              height: 200,
              child: ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: state.event.length,
                itemBuilder: (context, index) {
                  final event = state.event[index];
                  return AutoScrollTag(
                    controller: _controller,
                    index: index + 1,
                    key: ValueKey(index + 1),
                    child: EventCard(
                      imagePath: event.url!,
                      eventName: event.name!,
                      location: event.createdBy!,
                      latitud: event.latitud!,
                      longitud: event.longitud!,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      } else if (state is GetEventError) {
        return Center(
          child: Text(state.message),
        );
      }
      return const Center(child: CircularProgressIndicator());
    },
  );
}
