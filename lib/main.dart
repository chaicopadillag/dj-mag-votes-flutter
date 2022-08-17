import 'package:flutter/material.dart';
import 'package:djmag_votes/screens/screens.dart';

void main() => runApp(DjMagVoteApp());

class DjMagVoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DJ Mag Vote',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        // '/vote': (context) => VoteScreen(),
        // '/results': (context) => ResultsScreen(),
      },
    );
  }
}
