import 'package:mocktail/mocktail.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:tic_tac_toe_api/handlers/game_handler.dart';
import 'package:tic_tac_toe_api/models/game.dart';
import 'package:tic_tac_toe_api/services/game_service.dart';
import 'package:tic_tac_toe_api/utilities/result.dart';

class MockGameService extends Mock implements GameService {}

void main() {
  group('GameHandler tests', () {
    test('GET /games/{game_id} should return game details', () async {
      final gameService = MockGameService();
      final handler = GameHandler(gameService);

      when(() => gameService.getGame('123')).thenReturn(Result.success(Game(id: '123', board: [], status: 'IN_PROGRESS')));

      var request = Request('GET', Uri.parse('http://localhost/games/123'));
      var response = await handler.getGame(request);
      String body = await response.readAsString();

      expect(response.statusCode, 200);
      expect(body, '{"id":"123","board":[],"status":"IN_PROGRESS"}');

      verify(() => gameService.getGame('123')).called(1);
    });
  });

  test('GET /games/{game_id} should return game details when waiting for players', () async {
    final gameService = MockGameService();
    final handler = GameHandler(gameService);

    when(() => gameService.getGame('123')).thenReturn(Result.success(Game(id: '123', board: [], status: 'WAITING_FOR_PLAYERS')));

    var request = Request('GET', Uri.parse('http://localhost/games/123'));
    var response = await handler.getGame(request);
    String body = await response.readAsString();

    expect(response.statusCode, 200);
    expect(body, '{"id":"123","board":[],"status":"WAITING_FOR_PLAYERS"}');

    verify(() => gameService.getGame('123')).called(1);
  });

  test('GET /games/{game_id} should return 404 if game not found', () async {
    final gameService = MockGameService();
    final handler = GameHandler(gameService);

    when(() => gameService.getGame('222')).thenReturn(Result.failure(GameNotFoundException('Game not found')));

    var request = Request('GET', Uri.parse('http://localhost/games/222'));
    var response = await handler.getGame(request);

    expect(response.statusCode, 404);

    verify(() => gameService.getGame('222')).called(1);
  });

  test('GET /games/{game_id} should return 500 if an unknown error happens', () async {
    final gameService = MockGameService();
    final handler = GameHandler(gameService);

    when(() => gameService.getGame('333')).thenReturn(Result.failure(Exception('An unknown error occurred')));

    var request = Request('GET', Uri.parse('http://localhost/games/333'));
    var response = await handler.getGame(request);

    expect(response.statusCode, 500);

    verify(() => gameService.getGame('333')).called(1);
  });
}
