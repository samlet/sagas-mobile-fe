import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:catalog/bloc/bloc.dart';
import 'package:catalog/models/models.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  Stream<PostEvent> transform(Stream<PostEvent> events) {
    return (events as Observable<PostEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState( event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
        }
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts((currentState as PostLoaded).posts.length, 20);
          yield posts.isEmpty
              ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: (currentState as PostLoaded).posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (e, s) {
        print('Exception details:\n $e');
        print('Stack trace:\n $s');

        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
//        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
//        'http://localhost:5000/notes?_start=$startIndex&_limit=$limit');
          'http://localhost:8099/list_entities/NoteData?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      // final data = json.decode(response.body) as List;
      final jsonResponse = json.decode(response.body) as Map;

      // print('get '+jsonResponse['_result'].toString());
      // print(jsonResponse);

      var result=jsonResponse['_result'];
      if(result==0) {
        final data = jsonResponse['data'];
        return data.map((rawPost) {
          return Post(
            id: int.parse(rawPost['noteId']),
            title: rawPost['noteName'],
            body: rawPost['noteInfo'],
          );
        }).toList().cast<Post>();  // need add '.cast<Post>()'
      }else{
        print(jsonResponse['message']);
        print(jsonResponse['messages']);
        throw Exception('error fetching posts: '+jsonResponse['message']);
      }
    } else {
      throw Exception('error fetching posts');
    }
  }
}
