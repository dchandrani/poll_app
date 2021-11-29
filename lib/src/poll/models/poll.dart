import 'package:cloud_firestore/cloud_firestore.dart';

class Poll {
  const Poll({
    required this.id,
    required this.question,
    this.choices = const [],
  });

  final String id;
  final String question;
  final List<Choice> choices;

  Poll copyWith({
    List<Choice>? choices,
  }) {
    return Poll(
      id: id,
      question: question,
      choices: choices ?? this.choices,
    );
  }

  factory Poll.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Poll(
      id: snapshot.id,
      question: data['question'],
    );
  }
}

class Choice {
  const Choice({
    required this.choice,
    required this.votes,
    required this.id,
  });

  final String choice;
  final int votes;
  final String id;

  Choice copyWith({
    String? choice,
    int? votes,
    String? id,
  }) {
    return Choice(
      choice: choice ?? this.choice,
      votes: votes ?? this.votes,
      id: id ?? this.id,
    );
  }

  factory Choice.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Choice(
      id: snapshot.id,
      choice: snapshot.data()!['choice'],
      votes: snapshot.data()!['votes'],
    );
  }
}
