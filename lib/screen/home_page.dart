import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';

import '../resources/routes_manager.dart';

class HomePage extends StatefulWidget {
  //const HomePage({super.key});
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then(
        (value) => Navigator.pushReplacementNamed(context, Routes.onboarding));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AssetManager.background),
        ],
      ),
    );
  }
}
