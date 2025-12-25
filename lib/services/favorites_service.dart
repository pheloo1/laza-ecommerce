import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class FavoritesService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _requireUid() {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('No authenticated user. Favorites requires login.');
    }
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> _itemsRef() {
    final uid = _requireUid();
    return _db.collection('favorites').doc(uid).collection('items');
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> favoritesStream() {
    return _itemsRef().snapshots();
  }

  Future<bool> isFavorite(int productId) async {
    final doc = await _itemsRef().doc(productId.toString()).get();
    return doc.exists;
  }

  Future<void> toggleFavorite(Product product) async {
    final ref = _itemsRef().doc(product.id.toString());
    final doc = await ref.get();

    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set(product.toMap());
    }

    notifyListeners();
  }
}
