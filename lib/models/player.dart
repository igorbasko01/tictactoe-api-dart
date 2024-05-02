class Player {
  final String id;
  final String name;

  Player({required this.id, required this.name});

  String toJsonString() {
    return '{"id":"$id","name":"$name"}';
  }
}