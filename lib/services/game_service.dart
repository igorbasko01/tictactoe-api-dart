import 'package:tic_tac_toe_api/models/game.dart';
import 'package:tic_tac_toe_api/utilities/result.dart';

abstract class GameService {
  Result<Game> getGame(String gameId);
}

class GameServiceImpl implements GameService {
  @override
  Result<Game> getGame(String gameId) {
    return Result.success(Game(id: '123', board: [], status: 'IN_PROGRESS'));
  }
}

class GameNotFoundException implements Exception {
  final String message;

  GameNotFoundException(this.message);
}