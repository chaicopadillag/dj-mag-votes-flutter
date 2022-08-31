import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:djmag_votes/providers/providers.dart';
import 'package:djmag_votes/models/models.dart';

class ListVotes extends StatelessWidget {
  final List<Producer> producers;
  const ListVotes({Key? key, required this.producers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _votesChart(),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: producers.length,
              itemBuilder: (context, i) =>
                  _produceTitle(producers[i], context)),
        ),
      ],
    );
  }

  Widget _produceTitle(Producer producer, BuildContext context) {
    final socketProv = Provider.of<SocketProvider>(context, listen: false);
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
        socketProv.emit('delete-producer', {"id": producer.id});
      },
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(producer.name.substring(0, 1))),
        title: Text(producer.name),
        // subtitle: const Text('DJ Mag Votes 2022'),
        trailing: Text('${producer.votes}'),
        onTap: () {
          socketProv.emit('vote-producer', {"id": producer.id});
        },
      ),
    );
  }

  Widget _votesChart() {
    Map<String, double> dataMap = {};

    for (var producer in producers) {
      dataMap.putIfAbsent(producer.name, () => producer.votes.toDouble());
    }

    return SizedBox(
        width: double.infinity,
        height: 200,
        child: PieChart(
          dataMap: dataMap.isEmpty ? {'No datos': 0} : dataMap,
        ));
  }
}
