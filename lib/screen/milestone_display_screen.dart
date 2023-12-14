import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/milestones.dart';
import '../widgets/milestone_item.dart';
//import '../widgets/app_drawer.dart';
import './edit_milestone_screen.dart';

class MilestoneDisplayScreen extends StatelessWidget {
  static const routeName = '/display-milestone';

  @override
  Widget build(BuildContext context) {
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
      //drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
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
    );
  }
}
