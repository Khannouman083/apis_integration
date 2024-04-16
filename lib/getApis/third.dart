import 'dart:convert';
import 'package:apis/Models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<UserModel> userList=[];
  Future<List<UserModel>> getUserApi () async {
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data= jsonDecode(response.body.toString());
    if (response.statusCode==200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));

      }
      return userList;
    }
    else{
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text("Third Screen"),
              backgroundColor: Colors.deepOrange,
              centerTitle: true,
            ),
            body: Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
                    if (snapshot.connectionState==ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else{
                      return ListView.builder(
                          itemBuilder: (context, index){
                            return Card(
                              child:
                              Column(
                                children: [
                                    ReusableRow(title: "Name:",
                                        data: snapshot.data![index].name.toString(),
                                    ),
                                  ReusableRow(title: "Email:",
                                    data: snapshot.data![index].email.toString(),
                                  ),
                                  ReusableRow(title: "Phone Number:",
                                    data: snapshot.data![index].phone.toString(),
                                  ),
                                  ReusableRow(title: "User name:",
                                    data: snapshot.data![index].username.toString(),
                                  ),
                                  ReusableRow(title: "Address:",
                                    data: snapshot.data![index].address!.city.toString(),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            )
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
