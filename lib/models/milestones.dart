import 'package:flutter/material.dart';

import './milestone.dart';

class Milestones with ChangeNotifier {
  List<Milestone> _items = [
    Milestone(
      id: 'p1',
      type: 'First smile',
      remark: 'It was a great experience seeing my child first smile',
      milestoneDate: DateTime.now(),
    ),
    Milestone(
      id: 'p2',
      type: 'Rolling over',
      remark:
          'It happened in the middle of the night, just saw my baby lying on the belly',
      milestoneDate: DateTime.now(),
    ),
    Milestone(
      id: 'p3',
      type: 'sitting up',
      remark: 'my started sitting up not properly yet, she is still bending',
      milestoneDate: DateTime.now(),
    ),
  ];

  List<Milestone> get items {
    return [..._items];
  }

  Milestone findById(String id) {
    return _items.firstWhere((mil) => mil.id == id);
  }

  void addProduct(Milestone milestone) {
    final newMilestone = Milestone(
      type: milestone.type,
      remark: milestone.remark,
      milestoneDate: milestone.milestoneDate,
      id: DateTime.now().toString(),
    );
    _items.add(newMilestone);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Milestone newMilestone) {
    final milestoneIndex = _items.indexWhere((mil) => mil.id == id);
    if (milestoneIndex >= 0) {
      _items[milestoneIndex] = newMilestone;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((mil) => mil.id == id);
    notifyListeners();
  }
}
