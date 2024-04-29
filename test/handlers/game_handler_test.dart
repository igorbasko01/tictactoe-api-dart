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
}
