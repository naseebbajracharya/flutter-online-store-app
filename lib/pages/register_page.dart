import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget{
  @override

  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>{
  final _formKey = GlobalKey<FormState>();

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
                    obscureText: true,
                    decoration: InputDecoration(
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
                        RaisedButton(
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
                      onPressed:() => print('login')
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

  Widget _showContactField(){
    return Padding(
                  padding: EdgeInsets.only(top:15.0),
                  child: TextFormField(
                    //Validation
                    validator: (val) => val.length < 10 ? 'Phone number is short' : null,
                    keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
                      ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number',
                      hintText: 'Enter Your Contact Number',
                      
                      icon: Icon(Icons.phone_in_talk, color: Colors.black)
                    ),
                  ),);
  }

  void _submit(){
    final form = _formKey.currentState;

    if(form.validate()){
      form.save();
      print('Username: $_username, Email: $_email, Password: $_password, Address: $_address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _showContactField(),

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