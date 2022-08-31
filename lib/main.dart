import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:djmag_votes/screens/screens.dart';
import 'package:djmag_votes/providers/providers.dart';

void main() => runApp(DjMagVoteApp());

class DjMagVoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SocketProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DJ Mag Vote',
        initialRoute: 'index',
        routes: {
          'index': (context) => const HomeScreen(),
          'status': (context) => const StatusScreen(),
          // '/vote': (context) => VoteScreen(),
          // '/results': (context) => ResultsScreen(),
        },
      ),
    );
  }
}
