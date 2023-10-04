import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

Future<Album> fetchAlbum()async{
  final responce = await http.get(Uri.parse)('http://jsonplaceholder.typicode.com/albums/7');
  if(responce.statusCode == 200){
    return Album.fromJson(jsonDecode(responce.body));
  }else{
    throw Exception('Failed to load Album');
  }
}
class Album {
  final int userId;
  final String name;
  final String email;

  Album({
    required this.userId,
    required this.name,
    required this.email});

  factory  Album.fromJson(Map<String,dynamic> json){
    return Album(
        userId: json['userId'],
        name: json['name'],
        email: json['email']);
  }


}


class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState ();

  }

class _MyAppState extends State<MyApp> {
 late Future<Album> futureAlbum;
  @override

  void initState() {

    super.initState();
    futureAlbum=fetchAlbum();
  }
  Widget build(BuildContext context) {
return MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text('Data From Internet'),
    ),

    body: Center(
      child: FutureBuilder<Album>(
        future: futureAlbum,
        builder:(context,snapshot) {
          if (snapshot.hasData){
            return Column(
              children: [
                Text(snapshot.data!.userId.toString()),
                Text(snapshot.data!.name.toString()),
                Text(snapshot.data!.email),
              ],
            );
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    ),

  ),

);

  }
}













