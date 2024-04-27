import 'package:shelf/shelf.dart';
import 'package:tic_tac_toe_api/services/game_service.dart';

class GameHandler {
  final GameService _gameService;

  GameHandler(this._gameService);

  Future<Response> getGame(Request request) async {
    return Response.ok('{"id":"123","board":[],"status":"IN_PROGRESS"}');
  }
}