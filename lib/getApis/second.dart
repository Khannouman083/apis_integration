import 'dart:convert';

import 'package:apis/Models/photoModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class secondScreen extends StatefulWidget {
  const secondScreen({super.key});

  @override
  State<secondScreen> createState() => _secondScreenState();
}

class _secondScreenState extends State<secondScreen> {
  List<Photos> photoList = [];
  Future<List<Photos>> getPhotos () async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data= jsonDecode(response.body.toString());
    if (response.statusCode==200){
      for (Map i in data){
        Photos photos= Photos(
            title: i['title'],
            url: i['url'],);
        photoList.add(Photos as Photos);
      }
      return photoList;
    }
    else {
      return photoList;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Screen"),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
        ),
        body: FutureBuilder(future: getPhotos(),
            builder: (context,snapshot){
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else {
                return ListView.builder(
                   itemCount: photoList.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(photoList[index].url.toString()),
                        ),
                        title: Text(photoList[index].title.toString()),

                      );
                    });

              }
            }),
    );

  }
}
