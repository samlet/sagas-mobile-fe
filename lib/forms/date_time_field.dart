
import 'dart:async';

import 'package:catalog/authentication/authentication_bloc.dart';
import 'package:catalog/forms/form_common.dart';
import 'package:catalog/forms/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
            ),
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime
    );
    if (picked != null && picked != selectedTime)
      selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: _InputDropdown(
            labelText: labelText,
            valueText: DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () { _selectDate(context); },
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () { _selectTime(context); },
          ),
        ),
      ],
    );
  }
}

class DateRangeFieldCreator {
  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);

  // State<dynamic> state;
  DateRangeFieldCreator();

  void createFields(ScheduleBloc bloc, ScheduleState state,
      BuildContext context, List<Widget> widgets) {

    if(state is ScheduleLoaded){
      _fromDate=state.schedule.fromDate;
      _fromTime=state.schedule.fromTime;
      _toDate=state.schedule.toDate;
      _toTime=state.schedule.toTime;
    }
    widgets.add(
        _DateTimePicker(
          labelText: 'From',
          selectedDate: _fromDate,
          selectedTime: _fromTime,
          selectDate: (DateTime date) {
            /*
            state.setState(() {
              _fromDate = date;
            });
            */
            bloc.dispatch(ModifySchedule(vars: {"fromDate":date}));
          },
          selectTime: (TimeOfDay time) {
            /*
            state.setState(() {
              _fromTime = time;
            });
            */
            bloc.dispatch(ModifySchedule(vars: {"fromTime":time}));
          },
        ));
    widgets.add(
        _DateTimePicker(
          labelText: 'To',
          selectedDate: _toDate,
          selectedTime: _toTime,
          selectDate: (DateTime date) {
            bloc.dispatch(ModifySchedule(vars: {"toDate":date}));
          },
          selectTime: (TimeOfDay time) {
            bloc.dispatch(ModifySchedule(vars: {"toTime":time}));
          },
        ));
  }
}
