class Player {
  final String id;
  final String name;

  Player({required this.id, required this.name});

  String toJsonString() {
    return '{"id":"$id","name":"$name"}';
  }
}

class CreatePlayerRequest {
  final String playerName;

  CreatePlayerRequest({required this.playerName});

  factory CreatePlayerRequest.fromJson(Map<String, dynamic> json) {
    return CreatePlayerRequest(playerName: json['name']);
  }
}