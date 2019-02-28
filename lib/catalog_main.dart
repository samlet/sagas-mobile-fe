import 'package:catalog/app_config.dart';
import 'package:catalog/brokers/MesageReceiver.dart';
import 'package:catalog/charts/chart_list.dart';
import 'package:catalog/contacts/contacts_demo.dart';
//import 'package:catalog/forms/date_and_time_picker_demo.dart';
import 'package:catalog/forms/dynamic_picker.dart';
import 'package:catalog/forms/schedule_bloc.dart';
import 'package:catalog/forms/text_form_field_demo.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'package:catalog/authentication/authentication.dart';
import 'package:catalog/splash/splash.dart';
import 'package:catalog/login/login.dart';
import 'package:catalog/home/home.dart';
import 'package:catalog/common/common.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository(), receiver:MessageReceiver()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;
  final MessageReceiver receiver;

  App({Key key, @required this.userRepository,
    @required this.receiver}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;
  // Initialize app settings from the default configuration.
  bool _showPerformanceOverlay = defaultConfig.showPerformanceOverlay;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());

    //+
    widget.receiver.init();
    //+

    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            // return HomePage();
            // return DateAndTimePickerDemo(scheduleRepository:ScheduleRepository());
            return ChartList(
              showPerformanceOverlay: _showPerformanceOverlay,
              onShowPerformanceOverlayChanged: (bool value) {
                setState(() {
                  _showPerformanceOverlay = value;
                });
              },
            );

            // return DateAndTimePickerDemo();
            // return TextFormFieldDemo();
            // return ContactsDemo();
            /*
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: _userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            */
          },
        ),
      ),
    );
  }
}
