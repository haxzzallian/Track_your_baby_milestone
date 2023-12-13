import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/milestone_item.dart';
//import '../widgets/app_drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Milestone Dashboard'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                //add milestone page
              },
              icon: Icon(
                Icons.add,
              )),
        ],
      ),

      //drawer: AppDrawer(),
      //body: MilestoneItem(),
    );
  }
}
