import 'package:test/test.dart';
import 'package:tic_tac_toe_api/models/player.dart';

void main() {
  group('CreatePlayerRequest tests', () {
    test(
        'CreatePlayerRequest.fromJson should return a CreatePlayerRequest object',
        () {
      var json = {'name': 'Player 1'};
      var createPlayerRequest = CreatePlayerRequest.fromJson(json);

      expect(createPlayerRequest.playerName, 'Player 1');
    });

    test(
        'CreatePlayerRequest.fromJson should throw an exception if name field not present',
        () {
      var json = {'id': '1'};
      // Should throw a CreatePlayerRequestException with the message 'name field is required'
      expect(
          () => CreatePlayerRequest.fromJson(json),
          throwsA(predicate((e) =>
              e is CreatePlayerRequestException &&
              e.message == 'name field is required')));
    });

    test(
        'CreatePlayerRequest.fromJson should throw an exception if name field is empty',
        () {
      var json = {'name': ''};
      // Should throw a CreatePlayerRequestException with the message 'name field cannot be empty'
      expect(
          () => CreatePlayerRequest.fromJson(json),
          throwsA(predicate((e) =>
              e is CreatePlayerRequestException &&
              e.message == 'name field cannot be empty')));
        });
  });
}
