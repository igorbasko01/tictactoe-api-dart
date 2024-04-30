import 'package:shelf/shelf.dart';
import 'package:tic_tac_toe_api/services/game_service.dart';

class GameHandler {
  final GameService _gameService;

  GameHandler(this._gameService);

  Future<Response> getGame(Request request) async {
    var gameId = request.url.pathSegments[1];
    var game = _gameService.getGame(gameId);
    var response = game.when(
      success: (value) => Response.ok('{"id":"123","board":[],"status":"IN_PROGRESS"}'),
      failure: (error) {
        if (error is GameNotFoundException) {
          return Response.notFound('Game not found');
        } else {
          return Response.internalServerError(body: 'An unknown error occurred');
        }
      }
    );
    return response;
  }
}