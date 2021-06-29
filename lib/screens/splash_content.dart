import 'package:canteen_food_ordering_app/screens/constants.dart';
import 'package:canteen_food_ordering_app/screens/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text1,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, text1, image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                 Container(
                    height: getProportionateScreenHeight(120),
                    width: getProportionateScreenWidth(112),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:  new AssetImage("images/logo_karah.png"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),

                SizedBox(width: 50,),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(1, 70, 134, 1.0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "J'AI UNE QUESTION",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromRGBO(1, 70, 134, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Image.asset(
                image,
                height: getProportionateScreenHeight(240),
                width: getProportionateScreenWidth(240),
              ),

             Column(
               children: [
                 Text(
                  text1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(25),
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
               ],
             ),

              Expanded(
                flex: 20,
                child: Row(
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                      text,
                      textAlign: TextAlign.center,
                    ),
                 ],
             ),
              ),
          ],
        ),
    );

  }
}
