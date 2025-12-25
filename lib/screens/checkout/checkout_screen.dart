import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/cart_service.dart';
import 'success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: cartService.cartStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          final docs = snapshot.data!.docs;

          double total = 0.0;
          for (final doc in docs) {
            final price = (doc.data()['price'] as num?)?.toDouble() ?? 0.0;
            final qty = (doc.data()['quantity'] as num?)?.toInt() ?? 0;
            total += price * qty;
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data();
                      final title = (data['title'] ?? '').toString();
                      final price = (data['price'] as num?)?.toDouble() ?? 0.0;
                      final qty = (data['quantity'] as num?)?.toInt() ?? 0;
                      return ListTile(
                        title: Text(title),
                        subtitle: Text('Qty: $qty'),
                        trailing: Text('\$${(price * qty).toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                const Divider(),
                Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await cartService.clearCart();
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SuccessScreen()),
                        );
                      }
                    },
                    child: const Text('Confirm Order'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
