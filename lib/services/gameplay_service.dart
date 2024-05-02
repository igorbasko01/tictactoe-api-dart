import 'package:tic_tac_toe_api/models/player.dart';
import 'package:tic_tac_toe_api/utilities/result.dart';

abstract class GameplayService {
  Result<List<Player>> getPlayers(String gameId);
}

class GameplayServiceImpl implements GameplayService {
  @override
  Result<List<Player>> getPlayers(String gameId) {
    return Result.success([
      Player(id: '1', name: 'Player 1'),
      Player(id: '2', name: 'Player 2')
    ]);
  }
}