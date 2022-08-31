class Producer {
  String id;
  String name;
  int votes;

  Producer({required this.id, required this.name, required this.votes});

  factory Producer.fromJson(Map<String, dynamic> json) {
    return Producer(
      id: json.containsKey('id') ? json['id'] : 'no-id',
      name: json.containsKey('name') ? json['name'] : 'no name',
      votes: json.containsKey('votes') ? json['votes'] : 0,
    );
  }
}
