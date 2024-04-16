import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  var data;
  Future<void> getUser () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode==200){
    data= jsonDecode(response.body.toString());
    return data;
  }
  else {
    return data;
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fourth Screen"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: FutureBuilder(future: getUser(),
          builder:(context, snapshot){
           if (snapshot.connectionState==ConnectionState.waiting){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           else{
             return ListView.builder(
                 itemCount: data.length,
                 itemBuilder: (context, index){
                   return Card(
                     child: Column(
                       children: [
                         ReusableRow(title: "Name:", data: data[index]['name'].toString()),
                         ReusableRow(title: "Email:", data: data[index]['email'].toString()),
                         ReusableRow(title: "Phone:", data: data[index]['phone'].toString()),
                         ReusableRow(title: "Username:", data: data[index]['username'].toString()),
                         ReusableRow(title: "Address:", data: data[index]['address']['zipcode'].toString()),

                       ],
                     ),
                   );
                 });
           }
          }),

    );
  }
}


class ReusableRow extends StatefulWidget {
  String title, data;
  ReusableRow({super.key, required this.title, required this.data});

  @override
  State<ReusableRow> createState() => _ReusableRowState();
}

class _ReusableRowState extends State<ReusableRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
          Text(widget.data)
        ],
      ),
    );
  }
}
