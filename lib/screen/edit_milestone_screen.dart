import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/milestone.dart';
import '../models/milestones.dart';
import '../widgets/adaptive_text_button.dart';

//import '../widgets/app_drawer.dart';

class EditMilestoneScreen extends StatefulWidget {
  static const routeName = '/edit-milestone';

  @override
  State<EditMilestoneScreen> createState() => _EditMilestoneScreenState();
}

class _EditMilestoneScreenState extends State<EditMilestoneScreen> {
  final _typeFocusNode = FocusNode();
  final _remarkFocusNode = FocusNode();
  //final _dateController = FocusNode();
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
    //'imageUrl': '',
  };
  var _isInit = true;

  /* @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }*/

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final milestoneId = ModalRoute.of(context).settings.arguments as String;
      if (milestoneId != null) {
        _editedMilestone = Provider.of<Milestones>(context, listen: false)
            .findById(milestoneId);
        _initValues = {
          'type': _editedMilestone.type,
          'remark': _editedMilestone.remark,
          'milestoneDate': _editedMilestone.milestoneDate.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          //'imageUrl': '',
        };
        //_imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    /*_imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();*/
    //_dateController.dispose();
    _typeFocusNode.dispose();
    _remarkFocusNode.dispose();

    super.dispose();
  }

  /*void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }*/
  void _presentDatePicker() {
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
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedMilestone.id != null) {
      Provider.of<Milestones>(context, listen: false)
          .updateProduct(_editedMilestone.id, _editedMilestone);
    } else {
      Provider.of<Milestones>(context, listen: false)
          .addProduct(_editedMilestone);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
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
                            : 'Picked Date: ${DateFormat.yMMMEd().format(_dateController)}',
                      ),
                    ),
                    AdaptiveTextButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),

              /* Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: value,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
