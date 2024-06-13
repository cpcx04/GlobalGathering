// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/event/event_bloc.dart';
import 'package:global_gathering_application_1/bloc/post/post_bloc.dart';
import 'package:global_gathering_application_1/model/reponse/event_response.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:global_gathering_application_1/repository/event/event_repository_impl.dart';
import 'package:global_gathering_application_1/repository/post/post_repository.dart';
import 'package:global_gathering_application_1/repository/post/post_repository_impl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  final _formComment = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late PostBloc _postBloc;
  late PostRepository _postRepository;
  late EventBloc _eventBloc;
  late EventRepository _eventRepository;
  File? _image;
  String? _selectedEvent;
  bool _isLoading = false;
  List<AssetEntity> _galleryPhotos = [];
  bool _isFetchingPhotos = true;
  List<EventResponse> _events = [];

  @override
  void initState() {
    _postRepository = PostRepositoryImpl();
    _postBloc = PostBloc(_postRepository);
    _eventRepository = EventRepositoryImpl();
    _eventBloc = EventBloc(_eventRepository);
    super.initState();
    _requestPermissionAndFetchPhotos();
    _fetchEventList();
  }

  Future<void> _fetchEventList() async {
    _eventBloc.add(GetEventListEvent('events'));
  }

  Future<void> _requestPermissionAndFetchPhotos() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await _fetchGalleryPhotos();
    } else {
      setState(() {
        _isFetchingPhotos = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Permissions not granted to access gallery')),
      );
    }
  }

  Future<void> _fetchGalleryPhotos() async {
    try {
      print('Fetching albums...');
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );

      if (albums.isNotEmpty) {
        print('Albums found: ${albums.length}');
        final List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 20);
        setState(() {
          _galleryPhotos = photos;
          _isFetchingPhotos = false;
        });
        print('Photos fetched: ${photos.length}');
      } else {
        setState(() {
          _isFetchingPhotos = false;
        });
        print('No albums found');
      }
    } catch (e) {
      print('Error fetching photos: $e');
      setState(() {
        _isFetchingPhotos = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load gallery photos: $e')),
      );
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _postBloc.close();
    _eventBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_image == null) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final XFile? pickedFile =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      setState(() {
                        _image = File(pickedFile.path);
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Center(
                      child:
                          Icon(Icons.camera_alt, color: Colors.white, size: 50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: _isFetchingPhotos
                      ? const Center(child: CircularProgressIndicator())
                      : _galleryPhotos.isEmpty
                          ? const Center(child: Text('No photos found'))
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    3, // Cambia este valor según tus preferencias
                                crossAxisSpacing:
                                    4.0, // Espacio horizontal entre cada cuadro
                                mainAxisSpacing:
                                    4.0, // Espacio vertical entre cada cuadro
                              ),
                              itemCount: _galleryPhotos.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder<File?>(
                                  future: _galleryPhotos[index].file,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.data != null) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _image = snapshot.data;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Image.file(
                                            snapshot.data!,
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                ),
              ),
            ] else ...[
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(
                    _image!,
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _image = null;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<EventBloc, EventState>(
                bloc: _eventBloc,
                builder: (context, state) {
                  if (state is GetEventFetchSucess) {
                    _events = state.event;
                  } else if (state is GetEventError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.message}')),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      value: _selectedEvent,
                      hint: const Text('Select Event'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedEvent = newValue;
                        });
                      },
                      items: _events
                          .map<DropdownMenuItem<String>>((EventResponse event) {
                        return DropdownMenuItem<String>(
                          value: event.id ?? '',
                          child: Text(event.name ?? ''),
                        );
                      }).toList(),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      underline: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: _formComment,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://static.vecteezy.com/system/resources/thumbnails/011/381/900/small/young-businessman-3d-cartoon-avatar-portrait-png.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: 'Write a comment...',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'You can\'t post an empty comment';
                            }
                            return null;
                          },
                          style: GoogleFonts.inter(
                            fontSize: 14,
                          ),
                          maxLines: null, // Allow multiline input
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_image != null &&
                                    _selectedEvent != null &&
                                    _commentController.text.isNotEmpty) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  try {
                                    _postBloc.add(
                                      DoCreatePostEvent(
                                        file: _image!,
                                        relatedEvent: _selectedEvent!,
                                        comment: _commentController.text,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Failed to create post')),
                                    );
                                  } finally {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please complete all fields')),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 20, 12, 71),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                'Post',
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
