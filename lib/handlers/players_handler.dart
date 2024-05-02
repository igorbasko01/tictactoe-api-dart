import 'package:shelf/shelf.dart';
import 'package:tic_tac_toe_api/services/gameplay_service.dart';

class PlayersHandler {
  final GameplayService _gameplayService;

  PlayersHandler(this._gameplayService);

  Future<Response> getPlayers(Request request) async {
    var gameId = request.url.pathSegments[1];
    var result = _gameplayService.getPlayers(gameId);

    var response = result.when(
      success: (players) => Response.ok(
        players.map((player) => player.toJsonString()).toList().toString()
      ),
      failure: (error) => Response.internalServerError(body: 'An unknown error occurred')
    );
    return response;
  }
}