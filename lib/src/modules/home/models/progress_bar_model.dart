class ProgressBarState {
  final Duration current;
  final Duration buffered;
  final Duration total;

  const ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });

  factory ProgressBarState.initial() {
    return const ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    );
  }

  ProgressBarState copyWith({
    Duration? current,
    Duration? buffered,
    Duration? total,
  }) {
    return ProgressBarState(
      current: current ?? this.current,
      buffered: buffered ?? this.buffered,
      total: total ?? this.total,
    );
  }
}
