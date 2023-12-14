import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/milestones.dart';

class MilestoneDetailsScreen extends StatelessWidget {
  static const routeName = '/milestone-detail';
  final String type;
  final String remark;
  DateTime milestoneDate;

  MilestoneDetailsScreen({
    this.type,
    this.milestoneDate,
    this.remark,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                milestoneDate.toString(),
              ),
            ),
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
