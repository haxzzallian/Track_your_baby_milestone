// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../onBoarding/firstPage.dart';
import '../onBoarding/secondPage.dart';
import '../onBoarding/thirdPage.dart';

import '../resources/colors_manager.dart';
import '../resources/dimension_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/routes_manager.dart';
import '../screen/milestone_display_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();
  bool lastPage = false;
  bool isBack = false;

  List pages = [FirstPage(), SecondPage(), ThirdPage()];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: AppMargin.m20),
            alignment: Alignment.topRight,
            child: TextButton(
                onPressed: () => _controller.jumpToPage(pages.length),
                child: lastPage
                    ? Text(
                        "done",
                      )
                    : Text(
                        'skip',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    lastPage = (value == 2);
                    isBack = value < 1;
                  });
                },
                children: List.generate(pages.length, (index) => pages[index])),
          ),
          lastPage
              ? GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, MilestoneDisplayScreen.routeName),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      color: ColorsManager.lightPrimary,
                    ),
                    child: Text(
                      'done',
                      style:
                          TextStyle(color: ColorsManager.primary, fontSize: 15),
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 75,
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: WormEffect(
                          dotWidth: 13,
                          dotHeight: 13,
                          activeDotColor: ColorsManager.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                          ///////////////////////////////
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                            color: ColorsManager.lightPrimary,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'next',
                            style: TextStyle(
                                color: ColorsManager.primary, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
