import 'package:flutter/foundation.dart';

class Milestone with ChangeNotifier {
  final String id;
  final String type;
  final String remark;
  DateTime milestoneDate;

  Milestone({
    @required this.id,
    @required this.type,
    @required this.remark,
    @required this.milestoneDate,
  });
}
