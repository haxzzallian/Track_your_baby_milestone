import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/milestones.dart';
import './resources/routes_manager.dart';

import 'screen/home_page.dart';
import './screen/edit_milestone_screen.dart';
import './screen/milestone_display_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Milestones(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  button: TextStyle(color: Colors.white),
                ),
            errorColor: Colors.red,
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline1: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
            ),
          ),
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.homePage,
          routes: {
            //ProductDetailscreen.routeName: (ctx) => ProductDetailscreen(),
            EditMilestoneScreen.routeName: (ctx) => EditMilestoneScreen(),
            MilestoneDisplayScreen.routeName: (ctx) => MilestoneDisplayScreen(),
          },
          home: HomePage()),
    );
  }
}
