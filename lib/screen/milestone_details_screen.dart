import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/milestones.dart';

class MilestoneDetailsScreen extends StatelessWidget {
  static const routeName = '/milestone-detail';
  final String type;
  final String remark;
  DateTime milestoneDate;
  final String id;

  MilestoneDetailsScreen({this.type, this.milestoneDate, this.remark, this.id});

  @override
  Widget build(BuildContext context) {
    /*final milestoneId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedMileStone = Provider.of<Milestones>(
      context,
      listen: false,
    ).findById(milestoneId);*/

    return Scaffold(
      appBar: AppBar(
        title: Text(type),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 300,
                width: double.infinity,
                child: Text('milestoneDate')),
            SizedBox(height: 10),
            Text(
              type,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                remark,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
