import 'dart:async';

import 'package:catalog/authentication/authentication_bloc.dart';
import 'package:catalog/forms/date_time_field.dart';
import 'package:catalog/forms/dropdown_field.dart';
import 'package:catalog/forms/form_common.dart';
import 'package:catalog/forms/schedule_bloc.dart';
import 'package:catalog/forms/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DateAndTimePickerDemo extends StatefulWidget {
  static const String routeName = '/material/date-and-time-pickers';
  final ScheduleRepository scheduleRepository;

  DateAndTimePickerDemo({Key key, @required this.scheduleRepository})
      : assert(scheduleRepository != null),
        super(key: key);

  @override
  _DateAndTimePickerDemoState createState() => _DateAndTimePickerDemoState();
}

class _DateAndTimePickerDemoState extends State<DateAndTimePickerDemo> {
  ScheduleBloc _scheduleBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _scheduleBloc = ScheduleBloc(scheduleRepository: widget.scheduleRepository);
  }

  Widget _buildForm(BuildContext context, ScheduleState state) {
    List<Widget> widgets = new List<Widget>();

    var textCreator = TextFieldCreator();
    widgets.add(textCreator.createTitleTextField(context));
    widgets.add(textCreator.createTextField(context));

    DateRangeFieldCreator().createFields(_scheduleBloc, state, context, widgets);
    DropdownFieldCreator().createFields(_scheduleBloc, state, context, widgets);

    print(".. rebuild widgets");

    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widgets.length,
        itemBuilder: (context, i) {
          return widgets[i];
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
    BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic pickers'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(DateAndTimePickerDemo.routeName)],
      ),
      body: DropdownButtonHideUnderline(
        child: SafeArea(
          top: false,
          bottom: false,
          // child: _buildForm(),
          child: BlocBuilder(
              bloc: _scheduleBloc,
              builder: (_, ScheduleState state) {
                if (state is ScheduleEmpty) {
                  _scheduleBloc.dispatch(FetchSchedule(city: "hi"));
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ScheduleLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ScheduleLoaded) {
                  return _buildForm(context, state);
                }
                if (state is ScheduleError) {
                  return Text(
                    'Something went wrong!',
                    style: TextStyle(color: Colors.red),
                  );
                }
              }),
        ),
      ),

    );
  }
}

