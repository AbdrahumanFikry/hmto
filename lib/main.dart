import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senior/auth/loginScreen.dart';
import 'package:senior/providers/authenticationProvider.dart';
import 'package:senior/providers/location.dart';
import 'package:provider/provider.dart';
import 'package:senior/senior/SeniorNavigator.dart';
import 'package:senior/senior/startDay.dart';
import 'package:senior/senior/testStore.dart';
import 'package:senior/seniorAds/addStore.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitUp,
      ],
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Location(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
      ],
      child: MaterialApp(
        showSemanticsDebugger: false,
//          locale: Locale.fromSubtags(
//            languageCode: 'en',
//          ),
//          localizationsDelegates: [
//            const LocalizationDelegate(),
//            GlobalMaterialLocalizations.delegate,
//            GlobalWidgetsLocalizations.delegate,
//          ],
//          supportedLocales: [
//            const Locale('en', ''),
//            const Locale('ar', ''),
//          ],
        theme: ThemeData(
          iconTheme: IconThemeData(
            size: 16,
          ),
          textTheme: TextTheme(
            subhead: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
