import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/models/user.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/forgotPassword.dart';
import 'package:canteen_food_ordering_app/screens/signup.dart';
import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'adminHome.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  User _user = new User();
  bool isSignedIn = false, showPassword = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier, context);
    super.initState();
  }

  void toast(String data) {
    Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }

  void _submitForm() {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    RegExp regExp = new RegExp(
        r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if ('${_user.phone.trim()}@gmail.com'==null) {
      toast("Entrez un numero valide");
    } else if (_user.password.length < 8) {
      toast("Password must have atleast 8 characters");
    } else {
      print("Success");
      login(_user, authNotifier, context);
    }
  }

  Widget _buildLoginForm() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 120,
        ),
        // Email Text Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(1, 70, 134, 1.0)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.phone = value;
            },
            cursorColor: Color.fromRGBO(1, 70, 134, 1.0),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Téléphone',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(1, 70, 134, 1.0),
              ),
              icon: Icon(
                Icons.phone,
                color: Color.fromRGBO(1, 70, 134, 1.0),
              ),
            ),
          ),
        ), //EMAIL TEXT FIELD
        SizedBox(
          height: 20,
        ),
        // Password Text Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(1, 70, 134, 1.0)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: passwordController,
            obscureText: showPassword,
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.password = value;
            },
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Color.fromRGBO(1, 70, 134, 1.0),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    (showPassword) ? Icons.visibility_off : Icons.visibility,
                    color: Color.fromRGBO(1, 70, 134, 1.0),
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  }),
              border: InputBorder.none,
              hintText: 'Mot de passe',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(1, 70, 134, 1.0),
              ),
              icon: Icon(
                Icons.lock,
                color: Color.fromRGBO(1, 70, 134, 1.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //LOGIN BUTTON
        GestureDetector(
          onTap: (){_submitForm();
          /*async {
            print(phoneController.text);
            print(passwordController.text);
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+225${phoneController.text.trim()}',
              verificationCompleted: (AuthCredential credential) {
                print('everything is ok ');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AdminHomePage()),
                );
                // successDialog(context, "Tout est bien");
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
              verificationFailed: (AuthException error) {
                if (error.code == 'invalid-phone-number') {
                  print('The provided phone number is not valid.');
                } else {
                  errorDialog(context, "Error Message");
                  print(error.message.toString());
                }
              },
              timeout: const Duration(seconds: 20),
              // codeSent: (String verificationId, int forceResendingToken) {
              //   print('code sent');
              // },
            );*/
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(1, 70, 134, 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Connexion", 
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Forgot Password Line
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
              style: TextStyle(
                color: Color.fromRGBO(1, 70, 134, 1.0),
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ForgotPasswordPage();
                  },
                ));
              },
              child: Container(
                child: Text(
                  'Mot de passe oublié?',
                  style: TextStyle(
                      color: Color.fromRGBO(233, 106, 32, 1.0),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 10,
        ),
        Row(children: <Widget>[
          Expanded(
              child: Divider(
            color: Color.fromRGBO(1, 70, 134, 1.0),
            indent: 10,
          )),
          Container(
            height: 26.0,
            width: 30,
            child: Container(
              padding: const EdgeInsets.all(4.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.deepOrange,
              ),
              child: Text(
                'OU',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
              child: Divider(
            color: Color.fromRGBO(1, 70, 134, 1.0),
            endIndent: 10,
          )),
        ]),

        // SignUp Line
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
              style: TextStyle(
                color: Color.fromRGBO(1, 70, 134, 1.0),
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SignupPage();
                  },
                ));
              },
              child: Container(
                child: Text(
                  'Créer un nouveau compte',
                  style: TextStyle(
                      color: Color.fromRGBO(1, 70, 134, 1.0),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        /*child:Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage("images/logo_karah.png"),
                  fit: BoxFit.cover)),
        ),*/
        /*decoration: BoxDecoration(
          image: DecorationImage(
              image: new AssetImage("images/logo_karah.png"),
              fit: BoxFit.cover),
          /*gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),*/
        ),*/
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 60),
                    child: Text(
                      'Karah',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontFamily: 'MuseoModerno',
                      ),
                    ),
                  ),
                ),*/
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: new AssetImage("images/logo_karah.png"),
                          fit: BoxFit.cover)),
                ),
                Text(
                  'Connectez vous !',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromRGBO(1, 70, 134, 1.0),
                  ),
                ),
                Text(
                  'Entrez avec vos identifiants pour \n créer, suivre ou annuler une commande.',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color.fromRGBO(1, 70, 134, 1.0),
                  ),
                ),
                _buildLoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
