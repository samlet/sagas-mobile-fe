
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Schedule extends Equatable {
  DateTime fromDate = DateTime.now();
  TimeOfDay fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime toDate = DateTime.now();
  TimeOfDay toTime = const TimeOfDay(hour: 7, minute: 28);
  // final List<String> allActivities = <String>['hiking', 'swimming', 'boating', 'fishing'];
  List<String> allActivities;
  String activity = 'fishing';

  Schedule({
    this.fromDate, this.fromTime, this.toDate, this.toTime, this.allActivities, this.activity
  }) : super([
    fromDate, fromTime, toDate, toTime, allActivities, activity
  ]);

  static Schedule overridesSchedule(Map<String, dynamic> map) {
    return Schedule(
        fromDate: map['fromDate'],
        fromTime: map['fromTime'],
        toDate: map['toDate'],
        toTime: map['toTime'],
        allActivities: map['allActivities'],
        activity: map['activity']
    );
  }

  Map<String, dynamic> asMap() {
    return {'fromDate':fromDate, 'fromTime':fromTime, 'toDate':toDate, 'toTime':toTime, 'allActivities':allActivities, 'activity':activity};
  }
}

// ------------- states
abstract class ScheduleState extends Equatable {
  ScheduleState([List props = const []]) : super(props);
}

class ScheduleEmpty extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final Schedule schedule;

  ScheduleLoaded({@required this.schedule})
      : assert(Schedule != null),
        super([Schedule]);
}

class ScheduleError extends ScheduleState {}

// ---------- events

abstract class ScheduleEvent extends Equatable {
  ScheduleEvent([List props = const []]) : super(props);
}

class FetchSchedule extends ScheduleEvent {
  final String city;

  FetchSchedule({@required this.city})
      : assert(city != null),
        super([city]);
}

class RefreshSchedule extends ScheduleEvent {
  final String city;

  RefreshSchedule({@required this.city})
      : assert(city != null),
        super([city]);
}

class ModifySchedule extends ScheduleEvent {
final Map<String, dynamic> vars;

ModifySchedule({@required this.vars})
    : assert(vars != null),
super([vars]);
}

// ---------- bloc
class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc({@required this.scheduleRepository})
      : assert(scheduleRepository != null);

  @override
  ScheduleState get initialState => ScheduleEmpty();

  @override
  Stream<ScheduleState> mapEventToState(
      ScheduleState currentState,
      ScheduleEvent event,
      ) async* {
    if (event is FetchSchedule) {
      yield ScheduleLoading();
      try {
        final Schedule schedule = await scheduleRepository.getSchedule(event.city);
        yield ScheduleLoaded(schedule: schedule);
      } catch (_) {
        yield ScheduleError();
      }
    }

    if (event is RefreshSchedule) {
      /*
      try {
        final Schedule schedule = await scheduleRepository.getSchedule(event.city);
        yield ScheduleLoaded(schedule: schedule);
      } catch (_) {
        yield currentState;
      }
      */
      yield ScheduleLoading();
      Schedule schedule = await scheduleRepository.getSchedule(event.city);
      schedule.activity=event.city;
      yield ScheduleLoaded(schedule: schedule);
    }

    if (event is ModifySchedule){
      if(currentState is ScheduleLoaded) {
        yield ScheduleLoading();
        Schedule schedule = currentState.schedule;
        // create a new schedule object with original values and new values
        final props=schedule.asMap();
        props.addAll(event.vars);
        yield ScheduleLoaded(schedule: Schedule.overridesSchedule(props));
      }else{
        yield currentState;
      }
    }
  }
}

// -------------- repository
class ScheduleRepository {
  // final ScheduleApiClient ScheduleApiClient;

  ScheduleRepository();

  Future<Schedule> getSchedule(String city) async {
    // final int locationId = await ScheduleApiClient.getLocationId(city);
    // return await ScheduleApiClient.fetchSchedule(locationId);
    Schedule schedule=new Schedule()
      ..fromDate = DateTime.now()
      ..fromTime = const TimeOfDay(hour: 7, minute: 28)
      ..toDate = DateTime.now()
      ..toTime = const TimeOfDay(hour: 7, minute: 28)
      ..activity = 'fishing'
      ..allActivities = <String>['hiking', 'swimming', 'boating', 'fishing'];
    return schedule;
  }
}

