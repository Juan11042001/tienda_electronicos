import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Shipping Address'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Credit Card Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showOrderConfirmationDialog(context, cart);
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderConfirmationDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Order'),
          content: Text('Are you sure you want to place this order?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _completeOrder(context, cart);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _completeOrder(BuildContext context, CartProvider cart) {
    // Simulate order completion
    cart.clearCart();

    Navigator.of(context).pop(); // Close the confirmation dialog
    Navigator.of(context).pop(); // Close the checkout page

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order placed successfully!'),
      ),
    );
  }
}
