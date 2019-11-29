import 'package:catalog/forms/editor_meta.dart';
import 'package:catalog/forms/form_common.dart';
import 'package:catalog/forms/keys.dart';
import 'package:catalog/forms/todo.dart';
import 'package:catalog/widgets/password_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sagas_meta/sagas_meta.dart';
import 'localization.dart';

typedef OnSaveCallback = Function(FormDataCollector dc);

class Editor extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;
  final FormRepository formRepository;

  Editor({
    Key key,
    @required this.formRepository,
    @required this.onSave,
    @required this.isEditing,
    this.todo,
  }) : super(key: key ?? ArchSampleKeys.addTodoScreen);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  FormDataCollector _collector = FormDataCollector();

  bool get isEditing => widget.isEditing;
  FormBloc _formBloc;

  @override
  void initState() {
    _formBloc = FormBloc(formRepository: widget.formRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editTodo : localizations.addTodo,
          // isEditing ? 'Edit Todo' : 'Add Todo',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            // child: ListView(
            //  children: [ ],
            //),

            /*
            child: ListView.builder(
              itemCount: fieldCount,
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(context, index);
              },)
            */

            // <FormEvent, FormMetaState>
            child: BlocBuilder<FormEvent, FormMetaState>(
                bloc: _formBloc,
                builder: (
                  BuildContext context,
                  FormMetaState state,
                ) {
                  if (state is FormUninitialized) {
                    final uri =
                        "component://product/widget/catalog/ProductForms.xml;AddProductPaymentMethodType;en_US";
                    // final uri="component://content/widget/forum/BlogForms.xml;EditBlog;zh_CN";
                    _formBloc.dispatch(FormRetrieveEvent(uri: uri));
                  } else if (state is FormInitialized) {
                    return ListView.builder(
                      itemCount: fieldCount,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildItem(
                            context, index, state.formMeta, state.formData);
                      },
                    );
                  }

                  // return Text('Something ...');
                  return Center(child: CircularProgressIndicator());
                })),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            // collect: _task, _note
            _collector.values = {'task': _task, 'note': _note};
            widget.onSave(_collector);
            // Navigator.pop(context);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          }
        },
      ),
    );
  }

  String _validatePhoneNumber(String value) {
    // _formWasEdited = true;
    final RegExp phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '(###) ###-#### - Enter a US phone number.';
    return null;
  }

  String _validatePassword(String value) {
    // _formWasEdited = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please enter a password.';
    if (passwordField.value != value) return 'The passwords don\'t match';
    return null;
  }

  String _validateName(String value) {
    // _formWasEdited = true;
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  // final MetaForm formMeta;
  // final MetaSingleFormData formData;
  final List<String> _allActivities = <String>[
    'hiking',
    'swimming',
    'boating',
    'fishing'
  ];
  String _activity = 'fishing';
  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);

  final int fieldCount = 8;
  final UsNumberTextInputFormatter _phoneNumberFormatter =
      UsNumberTextInputFormatter();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  Widget _buildItem(BuildContext context, int index, MetaForm formMeta,
      MetaSingleFormData formData) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = ArchSampleLocalizations.of(context);

    switch (index) {
      case 0:
        return TextFormField(
          initialValue: isEditing ? widget.todo.task : '',
          key: ArchSampleKeys.taskField,
          autofocus: !isEditing,
          style: textTheme.headline,
          decoration: InputDecoration(
            hintText: localizations.newTodoHint,
          ),
          validator: (val) {
            return val.trim().isEmpty ? localizations.emptyTodoError : null;
          },
          onSaved: (value) => _task = value,
        );
        break;

      case 1:
        return TextFormField(
          initialValue: isEditing ? widget.todo.note : '',
          key: ArchSampleKeys.noteField,
          maxLines: 5,
          // 10,
          style: textTheme.subhead,
          decoration: InputDecoration(
            hintText: localizations.notesHint,
          ),
          onSaved: (value) => _note = value,
        );
        break;

      case 2:
        return TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.phone),
            hintText: 'Where can we reach you?',
            labelText: 'Phone Number *',
            prefixText: '+1',
          ),
          keyboardType: TextInputType.phone,
          onSaved: (String value) {
            _collector.values['phoneNumber'] = value;
          },
          validator: _validatePhoneNumber,
          // TextInputFormatters are applied in sequence.
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly,
            // Fit the validating format.
            _phoneNumberFormatter,
          ],
        );
        break;

      case 3:
        return PasswordField(
          fieldKey: _passwordFieldKey,
          helperText: 'No more than 8 characters.',
          labelText: 'Password *',
          onFieldSubmitted: (String value) {
            setState(() {
              _collector.values['password'] = value;
            });
          },
        );
        break;

      case 4:
        return ListTile(
          title: Text("Sender ?"),
          subtitle: Text("a person"),
        );
        break;

      case 5:
        //*
        return SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24.0),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: 'What do people call you?',
                      labelText: 'Name *',
                    ),
                    onSaved: (String value) {
                      _collector.values['name'] = value;
                    },
                    validator: _validateName,
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.phone),
                      hintText: 'Where can we reach you?',
                      labelText: 'Phone Number *',
                      prefixText: '+1',
                    ),
                    keyboardType: TextInputType.phone,
                    onSaved: (String value) {
                      _collector.values['phoneNumber'] = value;
                    },
                    validator: _validatePhoneNumber,
                    // TextInputFormatters are applied in sequence.
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                      // Fit the validating format.
                      _phoneNumberFormatter,
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.email),
                      hintText: 'Your email address',
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String value) {
                      _collector.values['email'] = value;
                    },
                  ),
                ]));
        //*/
        break;

      case 6:
        return SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24.0),
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Activity',
                      hintText: 'Choose an activity',
                      contentPadding: EdgeInsets.zero,
                    ),
                    isEmpty: _activity == null,
                    child: DropdownButton<String>(
                      value: _activity,
                      onChanged: (String newValue) {
                        setState(() {
                          _activity = newValue;
                        });
                      },
                      items: _allActivities
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ]));
        break;

      case 7:
        return SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                TextField(
                  enabled: true,
                  decoration: const InputDecoration(
                    labelText: 'Event name',
                    border: OutlineInputBorder(),
                  ),
                  style: Theme.of(context).textTheme.display1,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Location',
                  ),
                  style: Theme.of(context).textTheme.display1.copyWith(fontSize: 20.0),
                ),
                DateTimePicker(
                  labelText: 'From',
                  selectedDate: _fromDate,
                  selectedTime: _fromTime,
                  selectDate: (DateTime date) {
                    setState(() {
                      _fromDate = date;
                    });
                  },
                  selectTime: (TimeOfDay time) {
                    setState(() {
                      _fromTime = time;
                    });
                  },
                ),
                DateTimePicker(
                  labelText: 'To',
                  selectedDate: _toDate,
                  selectedTime: _toTime,
                  selectDate: (DateTime date) {
                    setState(() {
                      _toDate = date;
                    });
                  },
                  selectTime: (TimeOfDay time) {
                    setState(() {
                      _toTime = time;
                    });
                  },
                ),
                const SizedBox(height: 8.0),
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Activity',
                    hintText: 'Choose an activity',
                    contentPadding: EdgeInsets.zero,
                  ),
                  isEmpty: _activity == null,
                  child: DropdownButton<String>(
                    value: _activity,
                    onChanged: (String newValue) {
                      setState(() {
                        _activity = newValue;
                      });
                    },
                    items: _allActivities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ));
        break;
    }
  }
}
