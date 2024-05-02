import 'package:shelf/shelf.dart';
import 'package:tic_tac_toe_api/services/game_service.dart';

class GameHandler {
  final GameService _gameService;

  GameHandler(this._gameService);

  Future<Response> getGame(Request request) async {
    var gameId = request.url.pathSegments[1];
    var game = _gameService.getGame(gameId);
    var response = game.when(
      success: (value) => Response.ok(game.value?.toJsonString()),
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

  Future<Response> createGame(Request request) async {
    var game = _gameService.createGame();
    var response = game.when(
      success: (value) => Response(201, body: game.value?.toJsonString()),
      failure: (error) => Response.internalServerError(body: 'An unknown error occurred'),
    );
    return response;
  }
}