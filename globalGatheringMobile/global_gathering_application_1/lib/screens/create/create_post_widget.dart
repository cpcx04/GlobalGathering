import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/post/post_bloc.dart';
import 'package:global_gathering_application_1/repository/post/post_repository.dart';
import 'package:global_gathering_application_1/repository/post/post_repository_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  final TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late PostBloc _postBloc;
  late PostRepository _postRepository;
  XFile? _image;
  String? _selectedEvent;
  bool _isLoading = false;

  @override
  void initState() {
    _postRepository = PostRepositoryImpl();
    _postBloc = PostBloc(_postRepository);
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _image = pickedFile;
                });
              },
              child: _image == null
                  ? Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey[300],
                      child: Icon(Icons.add_a_photo, color: Colors.white),
                    )
                  : Image.file(
                      File(_image!.path),
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Comment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedEvent,
              hint: Text('Select Event'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedEvent = newValue;
                });
              },
              items: <String>[
                'c5827e72-f2cf-4889-811c-85d6313bdf1e',
                'Event 2',
                'Event 3'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
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
                          // No es necesario descargar la imagen, solo usar la ruta local
                          _postBloc.add(
                            DoCreatePostEvent(
                              file: XFile(_image!.path),
                              relatedEvent: _selectedEvent!,
                              comment: _commentController.text,
                            ),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to create post')),
                          );
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please complete all fields')),
                        );
                      }
                    },
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
