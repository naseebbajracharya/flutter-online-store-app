import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override

  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();

  bool _obsecureText = true;

  String _email, _password;

  Widget _showTitle(){
    return Text('Sign In', style: Theme.of(context).textTheme.headline);
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
                        RaisedButton(
                          child: Text('Sign In',
                          style: Theme.of(context).textTheme.body1.copyWith(color:Colors.white)),
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          color: Colors.green,
                          textColor: Colors.grey[50],
                          onPressed: _submit
                        ),

                    //For login redirects
                    FlatButton(
                      child: Text('New Here? Create Your Account Now!'),
                      onPressed:() => Navigator.pushReplacementNamed(context, '/register')
                    )
                    ],
                  )
                  );
  }

  void _submit(){
    final form = _formKey.currentState;

    if(form.validate()){
      form.save();
      print('Email: $_email, Password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
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

                  //Email Text Field
                  _showEmailField(),

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