import 'package:flutter/material.dart';
import 'screens/splashScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(uri: "http://35.221.4.209/graphql");
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