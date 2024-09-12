// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proje_intern/data_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Kulanıcı Adı",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder()
                    
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Kullanıcı adınızı giriniz";
                    } else {
                      return "null";
                    }
                  },
                  onSaved: (value) {
                    username = value ?? '';
                  },
                ),
              SizedBox(height: 10.0 ),
              TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Şifre",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder()
                    
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Şifrenizi giriniz";
                    } else {
                      return "null";
                    }
                  },
                  onSaved: (value) {
                    username = value ?? '';
                  },
                ),
                SizedBox(height: 50.0),
                _LoginButton()
            ],
          ),
        )),

    );
  }

  Widget _LoginButton() => 
    ElevatedButton(onPressed: (){
      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataPage()),
                    );
    }, child: Text("Giriş Yap"));

}
