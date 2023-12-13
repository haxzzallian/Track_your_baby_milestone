import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/dimension_manager.dart';

class FirstPage extends StatelessWidget {
  //const FirstPage({super.key});
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AssetManager.onboarding1),
        const SizedBox(
          height: AppMargin.m20,
        ),
        const Text(
          StringManager.onboarding1Title,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: AppMargin.m16,
        ),
        const Text(
          StringManager.onboarding1SubTitle,
          style: TextStyle(fontSize: 15, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
