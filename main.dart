import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:dio/dio.dart';
//import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());
class Post{
  String password;
  String email;
  String name;
  String mobilenumber;
  String buildingname;
  String buildnumber;
  String landmark;
  String roomno;
  Post({this.password,this.email,this.name,this.mobilenumber,this.buildingname,this.buildnumber,this.landmark,this.roomno});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        name: json['username'],
        password: json['passwordString'],
        mobilenumber: json['mobile'],
      email: json['email'],
        buildingname: json['buildingName'],
      buildnumber: json['buildingNo'],
      roomno: json['roomno'],
      landmark: json['landmark']

    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["passwordString"] = password;
    map["email"] = email;
    map["username"] = name;
    map["mobile"]=mobilenumber;
    map["buildingName"]=buildingname;
    map["buildingNo"]=buildnumber;
    map["landmark"]=landmark;
    map["roomno"]=roomno;


    return map;
  }
}
Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}
Post posts;

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);
  static final CREATE_POST_URL = "https://api.modernstores.in:8082/api/1|1|NER-1/public/register";
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
                        !val.contains('@') ? 'Invalid Email' :null,
                    onSaved: (val) => posts.email = val,

                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Password"),
                    validator: (val) => val.length < 6 ? 'Week Password' : null,
                    onSaved: (val) => posts.password= val,
                    obscureText: true,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Name"),
                    validator: (val) =>
                        val.length == 0 ? 'Name is Reqiured' : null,
                    onSaved: (val) => posts.name = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Mobile No"),
                    keyboardType: TextInputType.phone,
                    //validator:(val)=>val.length<10?'Mobile no Incorrect':null ,
                    onSaved: (val)=>posts.mobilenumber=val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Building Name"),
                    validator: (val) =>
                        val.length == 0 ? 'Building Name is Reqiured' : null,
                    onSaved: (val) => posts.buildingname = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Building No"),
                    validator: (val) =>
                        val.length == 0 ? 'Building Number is Reqiured' : null,
                    onSaved: (val) => posts.buildnumber = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "LandMark"),
                    validator: (val) =>
                        val.length == 0 ? 'Please Enter a Landmark' : null,
                    onSaved: (val) => posts.landmark = val,
                  ),
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                  new RaisedButton(
                    child: new Text("Register"),
                    onPressed: _submit,
                    color: Colors.blue,
                      //onPressed: () async {
                       // Post newPost = new Post(
                           // userId: "123", id: 0, title: titleControler.text, body: bodyControler.text);
                        //Post p = await createPost(CREATE_POST_URL,
                           // body: newPost.toMap());
                        //print(p.title);
                  )
                ],
              ))),
        ));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      //Post p= new createPost(CREATE_POST_URL,body:post.toMap());
      print(posts.name);
     // performLogin();
    }
  }




        //"https://api.modernstores.in:8082/api/1|1|NER-1/public/register";

}
