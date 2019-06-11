import 'package:http/http.dart' as http;
import 'contact.dart';
import 'dart:async';
import 'dart:convert';
//import 'package:intl/intl.dart';
class Contactservice {
  static const url =
      "https://api.modernstores.in:8082/api/1|1|NER-1/public/register";
  static final _headers = {'Content-Type': 'application/json'};
  Future<Contact> createContact(Contact contact) async {
    try {
      String json = _tojson(contact);
      final response = await http.post(url, headers: _headers, body: json);
      var c = _fromJson(response.body);
      return c;


    } catch (e) {
      print('server Exception');
      print(e);
      return null;
    }
  }

  Contact _fromJson(String jsonContact) {
    Map<String, dynamic> map = jsonDecode(jsonContact);
    var contact = new Contact();
    contact.name=map['username'];
    contact.password=map['passwordString'];
    contact.mobilenumber=map['mobile'];
    contact.email = map['email'];
    contact.buildingname=map['buildingName'];
    contact.buildnumber=map['buildingNo'];
    contact.roomno=map['roomNo'];
    contact.landmark=map['landmark'];
    return contact;
  }

  String_tojson(Contact contact) {
    var mapdata = new Map();
    mapdata["username"]=contact.name;
    mapdata["passwordString"]=contact.password;
    mapdata["mobile"]=contact.mobilenumber;
    mapdata["email"] = contact.email;
    mapdata["buildingName"]=contact.buildingname;
    mapdata["buildingNo"]=contact.buildnumber;
    mapdata["roomNo"]=contact.roomno;
    mapdata["landmark"]=contact.landmark;
    String jsonContact = jsonEncode(mapdata);
    return jsonContact;

  }
}
