import 'package:tic_tac_toe_api/models/game.dart';

abstract class GameService {
  Game getGame(String gameId);
}

class GameServiceImpl implements GameService {
  @override
  Game getGame(String gameId) {
    return Game(id: '123', board: [], status: 'IN_PROGRESS');
  }
}