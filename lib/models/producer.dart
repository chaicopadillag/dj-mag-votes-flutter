class Producer {
  String id;
  String name;
  int votes;

  Producer({required this.id, required this.name, required this.votes});

  factory Producer.fromJson(Map<String, dynamic> json) {
    return Producer(
      id: json['id'],
      name: json['name'],
      votes: json['votes'],
    );
  }
}
