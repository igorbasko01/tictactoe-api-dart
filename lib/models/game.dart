class Game {
  final String id;
  final List<List<String>> board;
  final String status;

  Game({required this.id, required this.board, required this.status});

  String toJsonString() {
    return '{"id":"$id","board":$board,"status":"$status"}';
  }
}