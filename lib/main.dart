import 'package:canteen_food_ordering_app/screens/constants.dart';
import 'package:canteen_food_ordering_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/screens/landingPage.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'notifiers/authNotifier.dart';

// void main() {
//   runApp(MyApp());
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => AuthNotifier(),
            ),
            // ChangeNotifierProvider(
            //   create: (_) => FoodNotifier(),
            // ),
          ],
          child: MyApp(),
        )
    );
  });

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kara',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor:  kPrimaryColor,
      ),
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
