import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data.dart';
import '../../domain.dart';

part 'stats_state.dart';

/// Holds logic for fetching and displaying game stats.
class StatsCubit extends Cubit<StatsState> {
  /// Constructor
  StatsCubit(this._statsRepository) : super(const StatsState());

  /// Interacts with storage for updating game stats.
  final GameStatsRepository _statsRepository;
}
