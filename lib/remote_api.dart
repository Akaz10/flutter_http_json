import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'models/Gonderi.dart';
/*
class RemoteApiKullanimi extends StatefulWidget {

  @override
  _RemoteApiKullanimiState createState() => _RemoteApiKullanimiState();
}

class _RemoteApiKullanimiState extends State<RemoteApiKullanimi> {

  getUserData() async {
    var response =
    await http.get(Uri.https('https://jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for(var u in jsonData){
      User user = User(u['name'],u['email'],u['username']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remote Api Kulanimi"),
      ),
      body: Center(child: ElevatedButton(child: Text("Click me"),onPressed: (){
        getUserData();
      },),),
    );
  }
}

class User {
  String name, email, userName;

  User(this.name, this.email, this.userName);
}
*/

class RemoteApiKullanimi extends StatefulWidget {
  @override
  _RemoteApiKullanimiState createState() => _RemoteApiKullanimiState();
}

class _RemoteApiKullanimiState extends State<RemoteApiKullanimi> {

  //Gonderi gonderi;
  Future<List<Gonderi>> _gonderiGetir() async {
    var response = await http
        .get(Uri.http('https://jsonplaceholder.typicode.com', '/posts'));

      return (json.decode(response.body) as List)
          .map((tekGonderiMap) => Gonderi.fromJsonMap(tekGonderiMap))
          .toList();

    //return Gonderi.fromJsonMap(json.decode(response.body));

  }

  @override
  /*void initState() {
    // TODO: implement initState
    super.initState();
    _gonderiGetir().then((okunanGonderi){
      gonderi =  okunanGonderi;
      debugPrint("gelen değer : "+gonderi.title);
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Remote Api Kulanimi"),
        ),
        body: FutureBuilder(
          future: _gonderiGetir(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Gonderi>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].body),
                    leading: CircleAvatar(
                      child: Text(snapshot.data[index].id.toString()),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
