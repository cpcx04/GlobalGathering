import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final String imagePath;
  final String username;
  final String event;
  final String comment;
  final String createdAt;

  PostWidget({
    Key? key,
    required this.imagePath,
    required this.username,
    required this.event,
    required this.comment,
    required this.createdAt,
  }) : super(key: key);

  Future<Map<String, String>> _getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<ImageProvider> _loadImage(String url) async {
    final modifiedUrl = url.replaceFirst('localhost', '10.0.2.2');
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse(modifiedUrl), headers: headers);
    if (response.statusCode == 200) {
      return MemoryImage(response.bodyBytes);
    } else {
      throw Exception('Failed to load image');
    }
  }

  String _formatDateToTimeAgo(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return timeago.format(dateTime, locale: 'es');
    } catch (e) {
      print('Error formatting date: $e');
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/008/846/297/small_2x/cute-boy-avatar-png.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 8),
                Text(
                  username,
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Mostrar la imagen en pantalla completa al tocarla
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(),
                    body: Center(
                      child: Hero(
                        tag: imagePath,
                        child: FutureBuilder<ImageProvider>(
                          future: _loadImage(imagePath),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Failed to load image'));
                            } else {
                              return InteractiveViewer(
                                child: Image(
                                  image: snapshot.data!,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Hero(
              tag: imagePath,
              child: FutureBuilder<ImageProvider>(
                future: _loadImage(imagePath),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Failed to load image'));
                  } else {
                    return Image(
                      image: snapshot.data!,
                      fit: BoxFit.cover,
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event,
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  comment,
                  style: GoogleFonts.manrope(color: Colors.grey),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      _formatDateToTimeAgo(createdAt),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
