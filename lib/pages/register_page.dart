import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget{
  @override

  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting, _obsecureText = true;

  String _username, _email, _password, _address;

  Widget _showTitle(){
    return Text('Sign Up', style: Theme.of(context).textTheme.headline);
  } 

  Widget _showUsernameField(){
    return Padding(
                  padding: EdgeInsets.only(top:15.0),
                  child: TextFormField(
                    onSaved: (val) => _username = val,
                    //Validation
                    validator: (val) => val.length < 5 ? 'Username is short' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter Username, min length 5',
                      icon: Icon(Icons.face, color: Colors.black)
                    ),
                  ),);
  }

  Widget _showEmailField(){
    return Padding(
                  padding: EdgeInsets.only(top:15.0),
                  child: TextFormField(
                    onSaved: (val) => _email = val,
                    //Validation
                    validator: (val) => !val.contains('@') ? 'Email is invalid' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email ID',
                      hintText: 'Enter Email',

                      icon: Icon(Icons.email, color: Colors.black)
                    ),
                  ),);
  }

  Widget _showPasswordField(){
    return Padding(
                  padding: EdgeInsets.only(top:15.0),
                  child: TextFormField(
                    onSaved: (val) => _password = val,
                    //Validation
                    validator: (val) => val.length < 5 ? 'Password is too short' : null,
                    obscureText: _obsecureText,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() => _obsecureText = !_obsecureText);
                        },
                        child: Icon(
                          _obsecureText ? Icons.visibility : Icons.visibility_off
                          ),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: '*******, min length 6',
                      icon: Icon(Icons.lock, color: Colors.black)
                    ),
                  ),);
  }

  Widget _showRegisterButton(){
    return Padding(
                    padding: EdgeInsets.only(top:15.0),
                    child: Column(
                      children: <Widget>[
                        _isSubmitting == true ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor)) : RaisedButton(
                          child: Text('Proceed',
                          style: Theme.of(context).textTheme.body1.copyWith(color:Colors.white)),
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.grey[50],
                          onPressed: _submit
                        ),

                    //For login redirects
                    FlatButton(
                      child: Text('Already a member? Login Now'),
                      onPressed:() => Navigator.pushReplacementNamed(context, '/login')
                    )
                    ],
                  )
                  );
  }

  Widget _showAddressField(){
    return Padding(
                  padding: EdgeInsets.only(top:15.0),
                  child: TextFormField(
                    onSaved: (val) => _address = val,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: 'Enter Your Address',
                      icon: Icon(Icons.location_on, color: Colors.black)
                    ),
                  ),);
  }


  void _submit(){
    final form = _formKey.currentState;

    if(form.validate()){
      form.save();
      _registerUser();
      //print('Username: $_username, Email: $_email, Password: $_password, Address: $_address');
    }
  }

  void _registerUser() async{
    setState(() => _isSubmitting = true);
    //using 10.0.2.2 instead of localhost:1337 because AVD uses 10.0.2.2
    http.Response response = await http.post('http://10.0.2.2:1337/auth/local/register', body: {
      "username": _username,
      "email": _email,
      "address": _address,
      "password": _password
    });

  final responseData = json.decode(response.body);
  if (response.statusCode == 200){
      
      setState(() => _isSubmitting = false);
      _storeUserData(responseData);
      _showSuccessSnack();
      _redirectUser();
      print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      final String errorMsg = responseData['message'];
      _showErrorSnack(errorMsg);
    }
  }

  void _storeUserData(responseData) async{
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData['user'];
    user.putIfAbsent('jwt', () => responseData['jwt']);
    prefs.setString('user', json.encode(user));
  }

  void _showSuccessSnack(){
    final snackbar = SnackBar(
    content: Text('Thank You $_username for signing up', 
    style: TextStyle(color: Colors.green),));
    _scaffoldKey.currentState.showSnackBar(snackbar); //displaying success msg
    _formKey.currentState.reset(); //reseting form after submit success
  }

   void _showErrorSnack(String errorMsg){
   final snackbar = SnackBar(
    content: Text(errorMsg, 
    style: TextStyle(color: Colors.red),));
    _scaffoldKey.currentState.showSnackBar(snackbar); //displaying error msg
    throw Exception('Error: $errorMsg');
  }

  void _redirectUser(){
    Future.delayed(Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, '/');
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //Page Title
                  _showTitle(),

                  //Username Text Field
                  _showUsernameField(),

                  //Email Text Field
                  _showEmailField(),

                  //Address Text Field
                  _showAddressField(),

                  //Address Text Field
                  // _showContactField(),

                  //Password Field
                  _showPasswordField(),

                  //Register & Login Redirect Button
                  _showRegisterButton(),
                  ],
              ),
            ),
          ),
        ),
      )
    );
  }
}