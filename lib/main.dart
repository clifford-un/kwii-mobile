import 'package:flutter/material.dart';
import 'screens/splashScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final String GRAPHQL_ENDPOINT = "http://35.245.79.61/graphql";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(uri: GRAPHQL_ENDPOINT);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink as Link,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    return GraphQLProvider(
      child: MaterialApp(
        title: 'Kwii',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.green,
        ),
        home: SplashScreen(),
      ),
      client: client,
    );
  }
}
