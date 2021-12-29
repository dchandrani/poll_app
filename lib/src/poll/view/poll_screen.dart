import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../poll.dart';

class PollScreen extends ConsumerWidget {
  const PollScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            poll.question,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final choice = poll.choices[index];

              return ChoiceItem(
                choice: choice,

              );
              // return ListTile(
              //   onTap: () {
              //     ref
              //         .read(pollControllerProvider.notifier)
              //         .updateVote(choice.id);
              //   },
              //   title: Text(choice.choice),
              //   trailing: Text('${choice.votes}'),
              // );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemCount: poll.choices.length,
          ),
        ],
      ),
    );
  }
}

class ChoiceItem extends ConsumerWidget {
  const ChoiceItem({
    Key? key,
    required this.choice,
  }) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context, ref) {
    final totalVotes = ref.read(pollControllerProvider).totalVotes;

    return GestureDetector(
      onTap: () {
        ref.read(pollControllerProvider.notifier).updateVote(choice.id);
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Builder(builder: (context) {
              final width = MediaQuery.of(context).size.width;

              final percent = choice.votes / totalVotes;
              print('percent: $percent');

              return Container(
                width: width * percent,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    choice.choice,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(choice.votes.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
