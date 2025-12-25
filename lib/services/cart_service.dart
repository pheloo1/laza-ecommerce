import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _requireUid() {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('No authenticated user. Cart requires login.');
    }
    return user.uid;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartStream() {
    final uid = _requireUid();
    return _db.collection('carts').doc(uid).collection('items').snapshots();
  }

  Future<void> addToCart(Product product) async {
    final uid = _requireUid();
    final ref = _db.collection('carts').doc(uid).collection('items').doc(product.id.toString());

    final doc = await ref.get();

    if (doc.exists) {
      await ref.update({'quantity': FieldValue.increment(1)});
    } else {
      await ref.set({
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'image': product.image,
        'quantity': 1,
      });
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    final uid = _requireUid();
    final ref = _db.collection('carts').doc(uid).collection('items').doc(productId);

    if (newQuantity <= 0) {
      await ref.delete();
      return;
    }

    await ref.update({'quantity': newQuantity});
  }

  Future<void> removeFromCart(String productId) async {
    final uid = _requireUid();
    await _db.collection('carts').doc(uid).collection('items').doc(productId).delete();
  }

  Future<void> clearCart() async {
    final uid = _requireUid();
    final items = await _db.collection('carts').doc(uid).collection('items').get();

    for (final doc in items.docs) {
      await doc.reference.delete();
    }
  }
}
