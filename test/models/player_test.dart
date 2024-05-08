import 'package:test/test.dart';
import 'package:tic_tac_toe_api/models/player.dart';

void main() {
  group('CreatePlayerRequest tests', () {
    test('CreatePlayerRequest.fromJson should return a CreatePlayerRequest object', () {
      var json = {'name': 'Player 1'};
      var createPlayerRequest = CreatePlayerRequest.fromJson(json);

      expect(createPlayerRequest.playerName, 'Player 1');
    });

    test('CreatePlayerRequest.fromJson should throw an exception if name field not present', () {});
    test('CreatePlayerRequest.fromJson should throw an exception if name field is empty', () {});
  });
}