import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poll_app/src/poll/models/poll.dart';

final fireStoreProvider = Provider((_) => FirebaseFirestore.instance);

final repositoryProvider = Provider(
  (ref) => Repository(
    firebaseFirestore: ref.read(
      fireStoreProvider,
    ),
  ),
);

class Repository {
  const Repository({
    required FirebaseFirestore firebaseFirestore,
  }) : _fireStore = firebaseFirestore;

  final FirebaseFirestore _fireStore;

  Future<Poll> fetchPoll() async {
    final questionRef =
        _fireStore.collection('poll').doc('vr1G4snOLx8A8tECegsN');
    final choiceRef = questionRef.collection('choices');

    final questionSnapshot = await questionRef.get();
    final choiceSnapshot = await choiceRef.get();

    final choices =
        choiceSnapshot.docs.map((e) => Choice.fromSnapshot(e)).toList();

    final poll = Poll.fromSnapshot(questionSnapshot);
    return poll.copyWith(
      choices: choices,
    );
  }

  Future<void> updateVote(
    String choiceId,
  ) async {
    final choice = _fireStore
        .collection('poll')
        .doc('vr1G4snOLx8A8tECegsN')
        .collection('choices')
        .doc(choiceId);

    choice.update({
      'votes': FieldValue.increment(1),
    });
  }
}
