import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/adminHome.dart';
import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  User _user = new User();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier, context);
    super.initState();
  }

  void toast(String data){
    Fluttertoast.showToast(
      msg: data,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white
    );
  }

  void _submitForm() {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    RegExp regExp = new RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if(!regExp.hasMatch(_user.email)){
      toast("Enter a valid Email ID");
    } else {
      print("Success");
      forgotPassword(_user, authNotifier, context);
    }
  }

  Widget _buildForgotPasswordForm() {
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
            border: Border.all(color: Color.fromRGBO(24, 142, 190, 1.0)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.phone= value;
            },
            cursorColor: Color.fromRGBO(1, 70, 134, 1.0),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Numéro de télephone',
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
        ),
        SizedBox(
          height: 50,
        ),
        //Reset Password BUTTON
        GestureDetector(
          onTap: /*() {
            _submitForm();
          },*/
              () async {
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
            );
            // _submitForm();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(1, 70, 134, 1.0),
              border: Border.all(color: Color.fromRGBO(24, 142, 190, 1.0)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Réinitialiser le mot de passe",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
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
        /*decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 138, 120, 1),
              Color.fromRGBO(255, 114, 117, 1),
              Color.fromRGBO(255, 63, 111, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),*/
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                GestureDetector(

                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: new AssetImage("images/logo_karah.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Mot de passe oublié',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                    color: Color.fromRGBO(1, 70, 134, 1.0),
                  ),
                ),
                _buildForgotPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
