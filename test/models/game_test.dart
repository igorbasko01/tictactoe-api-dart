import 'package:test/test.dart';
import 'package:tic_tac_toe_api/models/game.dart';

void main() {
  test('Game can be transformed to JSON', () {
    final game = Game(id: '123', board: [], status: 'IN_PROGRESS');
    final json = game.toJsonString();

    expect(json, '{"id":"123","board":[],"status":"IN_PROGRESS"}');
  });
}