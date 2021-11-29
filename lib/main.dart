import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/poll/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  // final questionRef =
  //     FirebaseFirestore.instance.collection('poll').doc('vr1G4snOLx8A8tECegsN');
  //
  // final questionSnapshot = await questionRef.get();

  runApp(
    const ProviderScope(
      child: PollApp(),
    ),
  );
}
