import 'package:flutter/material.dart';
import 'package:poll_app/src/poll/poll.dart';

class PollApp extends StatelessWidget {
  const PollApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Poll App',
      home: PollScreen(),
    );
  }
}
