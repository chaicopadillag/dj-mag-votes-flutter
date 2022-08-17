import 'package:djmag_votes/models/models.dart';
import 'package:flutter/material.dart';

class ListVotes extends StatelessWidget {
  final List<Producer> producers;
  const ListVotes({Key? key, required this.producers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: producers.length,
        itemBuilder: (context, i) => _produceTitle(producers[i]));
  }

  Widget _produceTitle(Producer producer) {
    return Dismissible(
      key: Key(producer.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        print(producer.name);
        producers.remove(producer);
      },
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(producer.name.substring(0, 1))),
        title: Text(producer.name),
        // subtitle: const Text('DJ Mag Votes 2022'),
        trailing: Text('${producer.votes}'),
        onTap: () {
          print('${producer.name} was tapped!');
        },
      ),
    );
  }
}
