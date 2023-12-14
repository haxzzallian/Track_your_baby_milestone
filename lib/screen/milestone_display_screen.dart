import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/milestones.dart';
import '../widgets/milestone_item.dart';
import './edit_milestone_screen.dart';
import '../resources/assets_manager.dart';

class MilestoneDisplayScreen extends StatelessWidget {
  static const routeName = '/display-milestone';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final milestonesData = Provider.of<Milestones>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your baby\'s Milestone'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditMilestoneScreen.routeName);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.35,
              width: size.width,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetManager.mother),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(children: [
                Positioned(
                  bottom: 1,
                  child: Column(
                    children: [
                      Text("Good day ",
                          style: Theme.of(context)
                              .appBarTheme
                              .textTheme
                              .headline1),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "How is your baby Today",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Container(
              height: size.height * 0.45,
              width: size.width,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: milestonesData.items.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    MilestoneItem(
                        milestonesData.items[i].id,
                        milestonesData.items[i].type,
                        milestonesData.items[i].remark,
                        milestonesData.items[i].milestoneDate),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
