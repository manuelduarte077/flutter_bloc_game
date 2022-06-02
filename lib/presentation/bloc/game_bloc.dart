import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data.dart';
import '../../domain.dart';

part 'game_event.dart';
part 'game_state.dart';

/// Handles all logic related to the game.
class GameBloc extends Bloc<GameEvent, GameState> {
  /// Constructor
  GameBloc(
    this._statsRepository,
  ) : super(GameState(guesses: emptyGuesses())) {
    on<GameStarted>(_onGameStarted);
    on<LetterKeyPressed>(_onLetterKeyPressed);
  }

  /// Interacts with storage for updating game stats.
  final GameStatsRepository _statsRepository;

  // TODO: Add logic for GameStarted

  void _onGameStarted(
    GameStarted event,
    Emitter<GameState> emit,
  ) {
    print('Game has Started');

    final puzzle = nextPuzzle(puzzles);
    final guesses = emptyGuesses();

    emit(
      state.copyWith(
        guesses: guesses,
        puzzle: puzzle,
      ),
    );
  }

  // TODO: Add logic for GameFinished

  // TODO: Add logic for LetterKeyPressed

  Future<void> _onLetterKeyPressed(
    LetterKeyPressed event,
    Emitter<GameState> emit,
  ) async {
    final guesses = addLetterToGuesses(state.guesses, event.letter);

    emit(state.copyWith(
      guesses: guesses,
    ));

    //TODO: check if the game ended
  }
}
