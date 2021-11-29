import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:poll_app/src/poll/models/poll.dart';
import 'package:collection/collection.dart';

import '../poll.dart';

part 'state.dart';

final pollControllerProvider =
    StateNotifierProvider.autoDispose<PollController, PollState>(
  (ref) => PollController(
    repository: ref.read(repositoryProvider),
  )..fetchPoll(),
);

class PollController extends StateNotifier<PollState> {
  PollController({
    required Repository repository,
  })  : _repository = repository,
        super(const PollState());

  final Repository _repository;

  fetchPoll() async {
    try {
      state = state.copyWith(status: PollStatus.fetchingPoll);

      final poll = await _repository.fetchPoll();
      state = state.copyWith(
        status: PollStatus.fetchPollSuccess,
        poll: poll,
      );
    } catch (e) {
      state = state.copyWith(
        status: PollStatus.fetchPollError,
        error: e.toString(),
      );
    }
  }

  updateVote(String choiceId) async {
    try {
      state = state.copyWith(status: PollStatus.updatingPoll);

      await _repository.updateVote(choiceId);

      final choices = state.poll?.choices ?? [];

      final updatedChoices = choices.map((choice) {
        if (choice.id == choiceId) {
          return choice.copyWith(votes: choice.votes + 1);
        }
        return choice;
      }).toList();

      state = state.copyWith(
        status: PollStatus.updatePollSuccess,
        poll: state.poll?.copyWith(
          choices: updatedChoices,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        status: PollStatus.updatePollError,
        error: e.toString(),
      );
    }
  }
}
