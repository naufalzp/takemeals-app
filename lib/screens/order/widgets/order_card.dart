import 'package:flutter/material.dart';
import 'package:takemeals/models/order_model.dart';
import 'package:takemeals/utils/constants.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${order.orderNumber}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${order.status}',
              style: TextStyle(color: Colors.black,),
            ),
            const SizedBox(height: 4),
            Text(
              'Quantity: ${order.quantity}',
              style: TextStyle(color: Colors.black,),
            ),
            const SizedBox(height: 4),
            Text(
              'Total Price: Rp. ${order.totalPrice}',
              style: TextStyle(color: Colors.black,),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: () {
              },
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}
