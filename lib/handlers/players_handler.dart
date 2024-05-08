import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:tic_tac_toe_api/models/player.dart';
import 'package:tic_tac_toe_api/services/game_service.dart';
import 'package:tic_tac_toe_api/services/gameplay_service.dart';

class PlayersHandler {
  final GameplayService _gameplayService;

  PlayersHandler(this._gameplayService);

  Future<Response> getPlayers(Request request) async {
    var gameId = request.url.pathSegments[1];
    var result = _gameplayService.getPlayers(gameId);

    var response = result.when(
        success: (players) => Response.ok(
            players.map((player) => player.toJsonString()).toList().toString()),
        failure: (error) {
          if (error is GameNotFoundException) {
            return Response.notFound('Game not found');
          } else {
            return Response.internalServerError(
                body: 'An unknown error occurred');
          }
        });
    return response;
  }

  Future<Response> createPlayer(Request request) async {
    var gameId = request.url.pathSegments[1];
    final playerRequestJson =
        jsonDecode(await request.readAsString()) as Map<String, dynamic>;
    final playerRequest = CreatePlayerRequest.fromJson(playerRequestJson);
    _gameplayService.createPlayer('123', 'Player 1');
    return Response(201, body: '{"id":"1","name":"Player 1"}');
  }
}
