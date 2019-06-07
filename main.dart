
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());
String password;
String email;
String name;
String mobilenumber;
String buildingname;
String buildnumber;
String landmark;
String roomno;

String url = "https://api.modernstores.in:8082/api/1|1|NER-1/public/register";

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: new ThemeData(),
      home: new formPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class formPage extends StatefulWidget {
  @override
  formPageState createState() => new formPageState();
}

class formPageState extends State<formPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text("Registration Form"),
        ),
        body: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
              key: formKey,
              child: new SingleChildScrollView(
                  child: new Column(
                children: <Widget>[
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Email"),
                    validator: (val) =>
                        !val.contains('@') ? 'Invalid Email' : null,
                    onSaved: (val) => email = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Password"),
                    validator: (val) => val.length < 6 ? 'Week Password' : null,
                    onSaved: (val) => password = val,
                    obscureText: true,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Name"),
                    validator: (val) =>
                        val.length == 0 ? 'Name is Reqiured' : null,
                    onSaved: (val) => name = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Mobile No"),
                    //keyboardType: TextInputType.phone,
                    validator: (val) =>
                    val.length == 0 ? 'mobilenumber is Reqiured' : null,

                    onSaved: (val) => mobilenumber = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Building Name"),
                    validator: (val) =>
                        val.length == 0 ? 'Building Name is Reqiured' : null,
                    onSaved: (val) => buildingname = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Building No"),
                    validator: (val) =>
                        val.length == 0 ? 'Building Number is Reqiured' : null,
                    onSaved: (val) => buildnumber = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Room No"),
                    validator: (val) =>
                        val.length == 0 ? 'Room Number is Reqiured' : null,
                    onSaved: (val) => roomno = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "LandMark"),
                    validator: (val) =>
                        val.length == 0 ? 'Please Enter a Landmark' : null,
                    onSaved: (val) => landmark = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new RaisedButton(
                    child: new Text("Register"),
                    onPressed: _submit,
                    color: Colors.blue,

                  )
                ],
              ))),
        ));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      performLogin();
    }
  }

  performLogin() async {
    var response = await http.post(
      Uri.encodeFull(url),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
      },
      body: { jsonEncode({
        'username':name,
        'passwordString': password,
        'mobile': mobilenumber,
        'email': email,
        'buildingName': buildingname,
        'buildingNo': buildnumber,
        'roomNo': roomno,
        'landmark': landmark,
      })},

    );
    print('Response status:${response.statusCode}');
    print('Response body:${response.body}');
  }

  //"https://api.modernstores.in:8082/api/1|1|NER-1/public/register";

}
