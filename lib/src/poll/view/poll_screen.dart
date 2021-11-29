import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../poll.dart';

class PollScreen extends StatelessWidget {
  const PollScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(pollControllerProvider);

            if (state.status == PollStatus.fetchingPoll) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == PollStatus.fetchPollError) {
              return const Center(child: Text('Error'));
            } else {
              return PollView(poll: state.poll!);
            }
          },
        ),
      ),
    );
  }
}

class PollView extends ConsumerWidget {
  const PollView({
    Key? key,
    required this.poll,
  }) : super(key: key);

  final Poll poll;

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            poll.question,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final choice = poll.choices[index];

              return ListTile(
                onTap: () {
                  ref
                      .read(pollControllerProvider.notifier)
                      .updateVote(choice.id);
                },
                title: Text(choice.choice),
                trailing: Text('${choice.votes}'),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: poll.choices.length,
          ),
        ],
      ),
    );
  }
}
