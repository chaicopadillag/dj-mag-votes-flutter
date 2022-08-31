import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:djmag_votes/providers/providers.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketProv = Provider.of<SocketProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Status:  ${socketProv.socketStatus}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          socketProv.socket.emit('message-flutter',
              {"name": "DevCode", "message": "Hello from Flutter"});
        },
      ),
    );
  }
}
