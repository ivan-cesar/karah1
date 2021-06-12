import 'package:canteen_food_ordering_app/screens/constants.dart';
import 'package:canteen_food_ordering_app/screens/default_button.dart';
import 'package:canteen_food_ordering_app/screens/login.dart';
import 'package:canteen_food_ordering_app/screens/signup.dart';
import 'package:canteen_food_ordering_app/screens/size_config.dart';
import 'package:canteen_food_ordering_app/screens/splash_content.dart';
import 'package:flutter/material.dart';

// This is the best practice

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {

      "image": "images/1.png",
      "text1": "Simplifiez vos \nprises de commandes",
      "text": "Passez toutes vos commandes de poulets\napoutchou directement depuis votre\nposition dans l'application Karah"

},
    {
      "text1":"La livraison est \ngratuite partout Abidjan",
      "text":
      "Abidjan, Bingerville et Grand Bassam, la livraison \nest à 0 FCFA quel que soit le nombre de poulets \napoutchou que vous commandez !",
      "image": "images/2.png"
    },
    {
      "text1":"Poulets tués, plumés, \nlivrés le même jour",
      "text": "Nos poulets sont halal, tués, plumés et livrés \nle même jour. Ce qui les rend frais à la réception. \nPassez votre commande maintenant!",
      "image": "images/3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text1: splashData[index]['text1'],
                  text: splashData[index]['text'],

                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 1),
                    DefaultButton(
                      text: "SE CONNECTER",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  LoginPage()),
                        );
                      },
                    ),
                    SizedBox(height:10.0),
                    MozartButton(
                      text: "S' INSCRIRE",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  SignupPage()),
                        );
                      },
                    ),
                    Spacer(),
                    Text(
                      'POWERD BY PROPULSE GROUP',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(1, 70, 134, 1.0),
                        //fontFamily: 'MuseoModerno',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
