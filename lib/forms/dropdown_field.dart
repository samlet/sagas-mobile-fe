import 'package:catalog/forms/schedule_bloc.dart';
import 'package:flutter/material.dart';

class DropdownFieldCreator {
  DropdownFieldCreator();

  void createFields(ScheduleBloc bloc, ScheduleState state,
      BuildContext context, List<Widget> widgets) {
    String _activity = 'fishing';
    List<String> _allActivities=[];
    if(state is ScheduleLoaded){
      print(".. load data");
      _activity=state.schedule.activity;
      _allActivities=state.schedule.allActivities;
    }

    widgets.add(const SizedBox(height: 8.0));
    widgets.add(InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Activity',
        hintText: 'Choose an activity',
        contentPadding: EdgeInsets.zero,
      ),
      isEmpty: _activity == null,
      child: DropdownButton<String>(
        value: _activity,
        onChanged: (String newValue) {
          /*
          state.setState(() {
            _activity = newValue;
            print(newValue);
          });
          */
          print("dispatch $newValue");
          // final bloc = BlocProvider.of<ScheduleBloc>(context);
          // bloc.dispatch(RefreshSchedule(city: newValue));
          bloc.dispatch(ModifySchedule(vars: {"activity":newValue}));
        },
        items: _allActivities.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ));
  }
}