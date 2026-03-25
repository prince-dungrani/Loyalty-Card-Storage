import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loyalty_card_storage_app/core/services/hive_service.dart';

class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> syncUp() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final cards = HiveService.getAllCards();
    final batch = _firestore.batch();

    for (var card in cards) {
      final docRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cards')
          .doc(card['id']);
      batch.set(docRef, card);
    }

    await batch.commit();
  }

  Future<void> syncDown() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final querySnapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cards')
        .get();

    for (var doc in querySnapshot.docs) {
      await HiveService.saveCard(doc.data());
    }
  }
}
