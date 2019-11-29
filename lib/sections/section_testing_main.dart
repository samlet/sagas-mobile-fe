import 'package:bloc/bloc.dart';
import 'package:catalog/app_config.dart';
import 'package:catalog/authentication/authentication.dart';
import 'package:catalog/brokers/MesageReceiver.dart';
import 'package:catalog/common/localization.dart';
import 'package:catalog/forms/localization.dart';
import 'package:catalog/listings/history_page.dart';
import 'package:catalog/sections/section_testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sagas_meta/sagas_bloc.dart';
import 'package:sagas_meta/sagas_meta.dart';
import 'package:user_repository/user_repository.dart';
import 'package:catalog/forms/receiver_model.dart';

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
  CommonSrvBloc _srvBloc;
  SrvClient _client;
  UserRepository get _userRepository => widget.userRepository;
  // Initialize app settings from the default configuration.
  bool _showPerformanceOverlay = defaultConfig.showPerformanceOverlay;

  //+ forms
  final FormRepository formRepository= new FormRepository(BrokerClient('blue_queue'));
  //+

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
    _client=new SrvClient(client:Client());
    _srvBloc=CommonSrvBloc(client: _client);

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
    /*
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
    */
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AuthenticationBloc>(bloc: _authenticationBloc),
        BlocProvider<CommonSrvBloc>(bloc: _srvBloc),
      ],
      child: MaterialApp(
        title: 'Sagas Blues',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          // fontFamily: 'Poppins',
        ),
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FlutterBlocLocalizationsDelegate(),
        ],
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {

            /*
            return Editor(
              formRepository: formRepository,
              key: ArchSampleKeys.addTodoScreen,
              onSave: (dc) {
                _srvBloc.dispatch(SimpleEv(message: 'tap modify.'));
                print('event posted.');
              },
              isEditing: false,);
            */
            // return HistoryPage(formRepository: formRepository);
            return SectionTestingPage(formRepository: formRepository, receiver: receivers[0]);
          },
        ),
      ),
    );
  }
}
