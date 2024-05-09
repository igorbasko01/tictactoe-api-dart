class Player {
  final String id;
  final String name;

  Player({required this.id, required this.name});

  String toJsonString() {
    return '{"id":"$id","name":"$name"}';
  }
}

class CreatePlayerRequest {
  final String name;

  CreatePlayerRequest({required this.name});

  factory CreatePlayerRequest.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('name')) {
      throw CreatePlayerRequestException('name field is required');
    }
    if (json['name'].isEmpty) {
      throw CreatePlayerRequestException('name field cannot be empty');
    }
    return CreatePlayerRequest(name: json['name']);
  }
}

class CreatePlayerRequestException implements Exception {
  final String message;

  CreatePlayerRequestException(this.message);
}