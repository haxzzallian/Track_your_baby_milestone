import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../screen/edit_milestone_screen.dart';
import '../screen/milestone_details_screen.dart';

import '../models/milestones.dart';

class MilestoneItem extends StatelessWidget {
  final String id;
  final String type;
  final String remark;
  final DateTime milestoneDate;

  MilestoneItem(this.id, this.type, this.remark, this.milestoneDate);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (ctx) => MilestoneDetailsScreen(
                      type: type,
                      milestoneDate: milestoneDate,
                      remark: remark,
                      //id: id,
                    )),
          );
        },
        child: Text(type),
      ),
      leading: CircleAvatar(
        child: FittedBox(
          child: Text(DateFormat.Md().format(milestoneDate)),
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditMilestoneScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Milestones>(context, listen: false)
                    .deleteMilestone(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
      subtitle: Text(remark),
    );
  }
}
