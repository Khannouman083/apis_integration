import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  void login (String email, password) async{
    try{
      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
      body: {
        'email' : email,
        'password' : password,
    });
      if(response.statusCode == 200){
        print("Log in successfully");
      }
      else{
        print("Log in Failed");
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in Screen"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: MediaQuery.of(context).size.height*.07,
                width: MediaQuery.of(context).size.width*.8,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("Log in")
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
