import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfilePage extends StatefulWidget{
  @override

  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state){
        
     return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage("images/user.png"),
            ),
            ListTile(
              title: Center(child:Text(state.user.username, style: TextStyle(fontSize: 25),)),
              subtitle: Center(child:Text(state.user.address, style: TextStyle(fontSize: 20),)),
            ),

            

            ListTile(
              title: Center(child:Text("Email Address:", style: TextStyle(fontSize: 20),)),
              subtitle: Center(child: Text(state.user.email, style: TextStyle(fontSize: 19),),
            ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              child: Text("View My Cart"),
            ),

             RaisedButton(
              onPressed: (){},
              child: Text("Add Cards"),
            ),
              ],
            ),
            ],
              ),
            ),
          ),
        ),
      )
    );
      });
    }
}