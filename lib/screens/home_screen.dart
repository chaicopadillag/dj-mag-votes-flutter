import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:djmag_votes/models/models.dart';
import 'package:djmag_votes/providers/socket_provider.dart';
import 'package:djmag_votes/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Producer> producers = [];

  @override
  void initState() {
    final socketProv = Provider.of<SocketProvider>(context, listen: false);

    socketProv.socket.on('producers', (payload) {
      producers = (payload as List)
          .map((producer) => Producer.fromJson(producer))
          .toList();

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketProv = Provider.of<SocketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DJ Mag Votes 2022',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: socketProv.socketStatus == SocketStatus.Online
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.offline_bolt,
                      color: Colors.red,
                    ))
        ],
      ),
      body: ListVotes(producers: producers),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewProducer,
        backgroundColor: Colors.blue,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addNewProducer() {
    showDialog(context: context, builder: (context) => AddProducerDialog());
  }

  AddProducerDialog() {
    final textEditing = TextEditingController();

    if (Platform.isAndroid) {
      return AlertDialog(
        title: const Text('Add new Producer'),
        content: TextField(
          controller: textEditing,
          decoration: const InputDecoration(
            labelText: 'Producer Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            child: const Text('Add'),
            onPressed: () => addProducerVote(textEditing.text),
          ),
        ],
      );
    }

    return CupertinoAlertDialog(
      title: const Text('Add new Producer'),
      content: CupertinoTextField(
        controller: textEditing,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFBDBDBD),
              width: 1,
            ),
          ),
        ),
        placeholder: 'Producer Name',
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: const Text('Add'),
          onPressed: () => addProducerVote(textEditing.text),
        ),
      ],
    );
  }

  addProducerVote(String text) {
    final socketProv = Provider.of<SocketProvider>(context, listen: false);

    if (text.isNotEmpty) {
      socketProv.emit('add-producer', {"name": text});
    }

    Navigator.of(context).pop();
  }
}
