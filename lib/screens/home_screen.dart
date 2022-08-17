import 'dart:io';

import 'package:djmag_votes/models/models.dart';
import 'package:djmag_votes/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Producer> producers = [
    Producer(id: '1', name: 'Avicii', votes: 100),
    Producer(id: '2', name: 'Martin Garrix', votes: 50),
    Producer(id: '3', name: 'Tiesto', votes: 40),
    Producer(id: '4', name: 'Armin van Burren', votes: 30),
    Producer(id: '5', name: 'Alan Walker', votes: 20),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DJ Mag Votes 2022',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
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
    print(text);

    if (text.isNotEmpty) {
      setState(() {
        producers.add(
            Producer(id: '${producers.length + 1}', name: text, votes: 10));
      });
    }

    Navigator.of(context).pop();
  }
}
