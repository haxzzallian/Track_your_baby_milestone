import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/milestone.dart';
import '../models/milestones.dart';

class EditMilestoneScreen extends StatefulWidget {
  static const routeName = '/edit-milestone';

  @override
  State<EditMilestoneScreen> createState() => _EditMilestoneScreenState();
}

class _EditMilestoneScreenState extends State<EditMilestoneScreen> {
  final _typeFocusNode = FocusNode();
  final _remarkFocusNode = FocusNode();

  DateTime _dateController;

  final _form = GlobalKey<FormState>();
  var _editedMilestone = Milestone(
    id: null,
    type: '',
    remark: '',
    milestoneDate: null,
  );
  var _initValues = {
    'type': '',
    'remark': '',
    'milestoneDate': '',
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final milestoneId = ModalRoute.of(context).settings.arguments as String;
      if (milestoneId != null) {
        _editedMilestone = Provider.of<Milestones>(
          context,
          listen: false,
        ).findById(milestoneId);
        _initValues = {
          'type': _editedMilestone.type,
          'remark': _editedMilestone.remark,
          'milestoneDate': _editedMilestone.milestoneDate.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _typeFocusNode.dispose();
    _remarkFocusNode.dispose();

    super.dispose();
  }

  void _saveForm() {
    _editedMilestone.milestoneDate = _dateController;
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedMilestone.id != null) {
      Provider.of<Milestones>(context, listen: false)
          .updateMilestone(_editedMilestone.id, _editedMilestone);
    } else {
      Provider.of<Milestones>(
        context,
        listen: false,
      ).addMilestone(_editedMilestone);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Baby\'s Milestone'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['type'],
                decoration: InputDecoration(labelText: 'Type'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_remarkFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMilestone = Milestone(
                    type: value,
                    remark: _editedMilestone.remark,
                    id: _editedMilestone.id,
                    milestoneDate: _editedMilestone.milestoneDate,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['remark'],
                decoration: InputDecoration(labelText: 'Remark'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _remarkFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a information about The Milestone.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMilestone = Milestone(
                    type: _editedMilestone.type,
                    milestoneDate: _editedMilestone.milestoneDate,
                    remark: value,
                    id: _editedMilestone.id,
                  );
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _dateController == null
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_dateController)}',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2019),
                          lastDate: DateTime.now(),
                        ).then((pickeddate) {
                          if (pickeddate == null) {
                            return;
                          }
                          setState(() {
                            //what user picked displays in textbox
                            _dateController = pickeddate;
                          });
                        });
                      },
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
