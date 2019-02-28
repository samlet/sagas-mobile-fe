import 'package:bloc/bloc.dart';
import 'package:catalog/bloc/bloc.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class TrackBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
    var state = transition.nextState;
    if (state is PostLoaded) {
      if (state.posts.isEmpty) {
        print("no posts.");
      } else {
        print("get ${state.posts.length}");
        for(var post in state.posts){
          print("${post.id} - ${post.title}");
        }
      }
    }
  }
}

//final _httpClient = new HttpClient();
void main() {
  BlocSupervisor().delegate = TrackBlocDelegate();

  final PostBloc _postBloc = PostBloc(httpClient: http.Client());

  _postBloc.dispatch(Fetch());
  print("...");
}
