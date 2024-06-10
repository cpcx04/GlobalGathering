import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/event/event_bloc.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:global_gathering_application_1/repository/event/event_repository_impl.dart';
import 'package:global_gathering_application_1/screens/book/profile_widget.dart';
import 'package:global_gathering_application_1/screens/create/create_screen.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:global_gathering_application_1/screens/post/post_screen.dart';
import 'package:global_gathering_application_1/screens/travel/travel_screen.dart';
import 'package:global_gathering_application_1/widgets/comments/comment_widget.dart';
import 'package:global_gathering_application_1/widgets/comments/own_comments_widget.dart';
import 'package:global_gathering_application_1/widgets/events/event_card.dart';
import 'package:global_gathering_application_1/widgets/events/events_my_event_card.dart';
import 'package:google_fonts/google_fonts.dart';

class BookedPage extends StatefulWidget {
  const BookedPage({Key? key}) : super(key: key);

  @override
  State<BookedPage> createState() => _BookedPageState();
}

class _BookedPageState extends State<BookedPage> {
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
          EventBloc(eventRepository)..add(DoGetMyEvent('event')),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PorfileWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Mi Perfil',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: 'Eventos'),
                          Tab(text: 'Comentarios'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _getMyEvents(),
                            ListView(children: [MyCommentWidget()]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                _buildBottomNavigationBarItem(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  icon: Icons.home,
                ),
                _buildBottomNavigationBarItem(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TravelPage(
                          latitud: 37.39216297919158,
                          longitud: -6.002893650469156,
                        ),
                      ),
                    );
                  },
                  icon: Icons.travel_explore,
                ),
                const SizedBox(),
                _buildBottomNavigationBarItem(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostScreen()),
                    );
                  },
                  icon: Icons.mode_of_travel_sharp,
                ),
                _buildBottomNavigationBarItem(
                  onPressed: () {},
                  icon: Icons.person,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 20, 12, 71),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateScreen()),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 25),
        ),
      ),
    );
  }

  Widget _getMyEvents() {
    return BlocBuilder<EventBloc, EventState>(builder: ((context, state) {
      if (state is GetEventFetchSucess) {
        return Container(
          height: 600,
          child: ListView.builder(
            itemCount: state.event.length,
            itemBuilder: (context, index) {
              final event = state.event[index];
              return MyEventCard(
                imagePath: event.url!,
                eventName: event.name!,
                location: event.createdBy!,
                latitud: event.latitud!,
                longitud: event.longitud!,
                date: event.date!,
              );
            },
          ),
        );
      } else if (state is GetEventError) {
        return Center(
          child: Text(state.message),
        );
      }
      return const Center(child: CircularProgressIndicator());
    }));
  }

  Widget _buildBottomNavigationBarItem({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Colors.white,
      ),
    );
  }
}
