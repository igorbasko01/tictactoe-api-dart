import 'package:mocktail/mocktail.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:tic_tac_toe_api/handlers/players_handler.dart';
import 'package:tic_tac_toe_api/models/player.dart';
import 'package:tic_tac_toe_api/services/game_service.dart';
import 'package:tic_tac_toe_api/services/gameplay_service.dart';
import 'package:tic_tac_toe_api/utilities/result.dart';

class MockGameplayService extends Mock implements GameplayService {}

void main() {
  group('PlayersHandler tests', () {
    test(
        'GET /games/{game_id}/players should return a list of players in the game',
        () async {
      var gamePlayService = MockGameplayService();
      var handler = PlayersHandler(gamePlayService);

      when(() => gamePlayService.getPlayers('123')).thenReturn(Result.success([
        Player(id: '1', name: 'Player 1'),
        Player(id: '2', name: 'Player 2')
      ]));

      var request =
          Request('GET', Uri.parse('http://localhost/games/123/players'));
      var response = await handler.getPlayers(request);
      var body = await response.readAsString();

      expect(response.statusCode, 200);
      expect(
          body, '[{"id":"1","name":"Player 1"}, {"id":"2","name":"Player 2"}]');

      verify(() => gamePlayService.getPlayers('123')).called(1);
    });

    test('GET /games/{game_id}/players should return a single player if it is so', () async {
      var gamePlayService = MockGameplayService();
      var handler = PlayersHandler(gamePlayService);

      when(() => gamePlayService.getPlayers('123')).thenReturn(Result.success([
        Player(id: '1', name: 'Player 1')
      ]));

      var request =
          Request('GET', Uri.parse('http://localhost/games/123/players'));
      var response = await handler.getPlayers(request);
      var body = await response.readAsString();

      expect(response.statusCode, 200);
      expect(body, '[{"id":"1","name":"Player 1"}]');

      verify(() => gamePlayService.getPlayers('123')).called(1);
    });

    test('GET /games/{game_id}/players should return an empty list if there are no players', () async {
      var gamePlayService = MockGameplayService();
      var handler = PlayersHandler(gamePlayService);

      when(() => gamePlayService.getPlayers('123')).thenReturn(Result.success([]));

      var request =
          Request('GET', Uri.parse('http://localhost/games/123/players'));
      var response = await handler.getPlayers(request);
      var body = await response.readAsString();

      expect(response.statusCode, 200);
      expect(body, '[]');

      verify(() => gamePlayService.getPlayers('123')).called(1);
    });

    test('GET /games/{game_id}/players should return 404 if game not found', () async {
      var gamePlayService = MockGameplayService();
      var handler = PlayersHandler(gamePlayService);

      when(() => gamePlayService.getPlayers('222')).thenReturn(Result.failure(GameNotFoundException('Game not found')));

      var request =
          Request('GET', Uri.parse('http://localhost/games/222/players'));
      var response = await handler.getPlayers(request);

      expect(response.statusCode, 404);

      verify(() => gamePlayService.getPlayers('222')).called(1);
    });

    test('GET /games/{game_id}/players should return 500 if an unknown error happens', () async {
      var gamePlayService = MockGameplayService();
      var handler = PlayersHandler(gamePlayService);

      when(() => gamePlayService.getPlayers('333')).thenReturn(Result.failure(Exception('An unknown error occurred')));

      var request =
          Request('GET', Uri.parse('http://localhost/games/333/players'));
      var response = await handler.getPlayers(request);

      expect(response.statusCode, 500);

      verify(() => gamePlayService.getPlayers('333')).called(1);
    });

    test('POST /games/{game_id}/players should return 201 if player is created', () async {
      var gamePlayService = MockGameplayService();
      var handler = PlayersHandler(gamePlayService);

      when(() => gamePlayService.createPlayer('123', 'Player 1')).thenReturn(Result.success(Player(id: '1', name: 'Player 1')));

      var request = Request('POST', Uri.parse('http://localhost/games/123/players'));
      request = request.change(body: '{"name": "Player 1"}');
      var response = await handler.createPlayer(request);
      var body = await response.readAsString();

      expect(response.statusCode, 201);
      expect(body, '{"id":"1","name":"Player 1"}');

      verify(() => gamePlayService.createPlayer('123', 'Player 1')).called(1);
    });

    test('POST /games/{game_id}/players should return 201 if player created for another game', () {});
    test('POST /games/{game_id}/players should return 404 if game not found', () async {});
    test('POST /games/{game_id}/players should return 500 if an unknown error happens', () async {});
    test('POST /games/{game_id}/players should return 400 if player name is missing', () async {});
    test('POST /games/{game_id}/players should return 400 if player name is empty', () async {});
    test('POST /games/{game_id}/players should return 400 if player name is too long', () async {});
    test('POST /games/{game_id}/players should return 400 if player name is already taken', () async {});
    test('POST /games/{game_id}/players should return 400 if game is already full', () async {});
    test('DELETE /games/{game_id}/players/{player_id} should return 204 if player is deleted', () async {});
    test('DELETE /games/{game_id}/players/{player_id} should return 404 if player not found', () async {});
    test('DELETE /games/{game_id}/players/{player_id} should return 500 if an unknown error happens', () async {});
    test('DELETE /games/{game_id}/players/{player_id} should return 404 if game not found', () async {});
    test('DELETE /games/{game_id}/players/{player_id} should return 400 if game is in progress', () async {});
  });
}
