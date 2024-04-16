import 'dart:convert';

import 'package:apis/Models/postModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class firstScreen extends StatefulWidget {
  const firstScreen({super.key});

  @override
  State<firstScreen> createState() => _firstScreenState();
}

class _firstScreenState extends State<firstScreen> {
  
  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApi () async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data= jsonDecode(response.body.toString());
    if(response.statusCode==200) {
      for(Map i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }
    else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getPostApi(),
          builder: (context, snapshot){
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            else{
              return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title:", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(postList[index].title.toString()),
                          Text("Body:", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(postList[index].body.toString()),
                        ],
                      ),
                    );

                  });
            }
          }),
    );

  }
}
