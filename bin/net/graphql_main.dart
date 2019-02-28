import 'package:sagas_common/graphql_client/client.dart';
import 'package:sagas_common/queries/readRepositories.dart' as queries;
import 'package:sagas_common/graphql_client/in_memory.dart';

Future main() async {
  print('.. fetching');

  Map<String, dynamic> variables = const {};
  Client client=Client(
    endPoint: 'https://api.github.com/graphql',
    cache: InMemoryCache(),
    // apiToken: '<YOUR_GITHUB_PERSONAL_ACCESS_TOKEN>',
    apiToken: '90ff87455ba228ffca5796f79abf3bc050f91544',
  );

  final Map<String, dynamic> result = await client.query(
    query: queries.readRepositories,
    variables: variables,
  );
  List repositories = result['viewer']['repositories']['nodes'];
  for(dynamic repo in repositories){
    print(repo);
  }
}
