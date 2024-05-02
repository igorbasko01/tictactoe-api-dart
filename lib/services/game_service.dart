import 'package:tic_tac_toe_api/models/game.dart';
import 'package:tic_tac_toe_api/utilities/result.dart';

abstract class GameService {
  Result<Game> getGame(String gameId);
  Result<Game> createGame();
}

class GameServiceImpl implements GameService {
  @override
  Result<Game> getGame(String gameId) {
    return Result.success(Game(id: '123', board: [], status: 'IN_PROGRESS'));
  }

  @override
  Result<Game> createGame() {
    return Result.success(Game(id: '123', board: [], status: 'WAITING_FOR_PLAYERS'));
  }
}

class GameNotFoundException implements Exception {
  final String message;

  GameNotFoundException(this.message);
}