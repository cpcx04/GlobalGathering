import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/post/post_bloc.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:global_gathering_application_1/repository/post/post_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:global_gathering_application_1/screens/book/booked_page.dart';
import 'package:global_gathering_application_1/screens/create/create_screen.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:global_gathering_application_1/screens/travel/travel_screen.dart';
import 'package:global_gathering_application_1/widgets/post/post-widget.dart';

import '../../repository/post/post_repository_impl.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(postRepository)..add(GetAllMyPostEvent('posts')),
      child: Scaffold(
        extendBody: true,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _postList(),
                ],
              ),
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
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    icon: const Icon(Icons.home),
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
                            builder: (context) => TravelPage(
                                  latitud: 37.39216297919158,
                                  longitud: -6.002893650469156,
                                )),
                      );
                    },
                    icon: const Icon(Icons.travel_explore),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mode_of_travel_sharp),
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookedPage()),
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

  Widget _postList() {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is GetAllMyPostFetchSuccess) {
        // Filtra y ordena la lista de posts por fecha de creación
        final filteredPosts =
            state.posts.where((post) => post.createdAt != null).toList();
        filteredPosts.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredPosts.length,
          itemBuilder: (context, index) {
            final post = filteredPosts[index];
            return PostWidget(
              comment: post.comment!,
              event: post.relatedEvent!,
              imagePath: post.uri!,
              username: post.createdBy!,
              createdAt: post.createdAt!,
            );
          },
        );
      } else if (state is GetPostFetchLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is PostErrorState) {
        return Center(child: Text('Failed to load posts'));
      }
      return Container();
    });
  }
}
