part of 'controller.dart';

enum PollStatus {
  fetchingPoll,
  fetchPollError,
  fetchPollSuccess,
  updatingPoll,
  updatePollError,
  updatePollSuccess
}

class PollState extends Equatable {
  final PollStatus status;
  final String? error;
  final Poll? poll;
  final int totalVotes;

  const PollState({
    this.status = PollStatus.fetchingPoll,
    this.error,
    this.poll,
    this.totalVotes = 0,
  });

  PollState copyWith({
    PollStatus? status,
    String? error,
    Poll? poll,
    int? totalVotes,
  }) {
    return PollState(
      status: status ?? this.status,
      error: error ?? this.error,
      poll: poll ?? this.poll,
      totalVotes: totalVotes ?? this.totalVotes,
    );
  }

  @override
  List<Object?> get props => [status, error, poll, totalVotes];
}
