import 'package:canteen_food_ordering_app/screens/constants.dart';
import 'package:canteen_food_ordering_app/screens/navigationBar.dart';
import 'package:canteen_food_ordering_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/screens/landingPage.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Future<Widget> build(BuildContext context) async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kara',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor:  kPrimaryColor,
      ),
      home: status == true ?  Scaffold(
        body: SplashScreen()):NavigationBarPage(selectedIndex: 2),

    );
  }
}
