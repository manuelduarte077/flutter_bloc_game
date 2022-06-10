import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
    on<LetterKeyPressed>(_onLetterKeyPressed, transformer: sequential());
    on<GameFinished>(_onGameFinished);
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

  Future<void> _onGameFinished(
    GameFinished event,
    Emitter<GameState> emit,
  ) async {
    await _statsRepository.addGameFinished(hasWon: event.hasWon);

    emit(state.copyWith(
      status: event.hasWon ? GameStatus.success : GameStatus.failure,
    ));
  }

  // TODO: Add logic for LetterKeyPressed

  Future<void> _onLetterKeyPressed(
    LetterKeyPressed event,
    Emitter<GameState> emit,
  ) async {
    final puzzle = state.puzzle;
    final guesses = addLetterToGuesses(state.guesses, event.letter);

    emit(state.copyWith(guesses: guesses));

    final words = guesses
        .map((guesses) => guesses.join())
        .where((word) => word.isNotEmpty)
        .toList();

    final hasHow = words.contains(puzzle);
    final hasMaxAttempts = words.length == kMaxGuesses &&
        words.every((word) => word.length == kWordLength);

    if (hasHow || hasMaxAttempts) {
      add(GameFinished(hasWon: hasHow));
    }

    //TODO: check if the game ended
  }
}
