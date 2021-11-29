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

  const PollState({
    this.status = PollStatus.fetchingPoll,
    this.error,
    this.poll,
  });

  PollState copyWith({
    PollStatus? status,
    String? error,
    Poll? poll,
  }) {
    return PollState(
      status: status ?? this.status,
      error: error ?? this.error,
      poll: poll ?? this.poll,
    );
  }

  @override
  List<Object?> get props => [status, error, poll];
}
