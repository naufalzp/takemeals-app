
import 'package:flutter/material.dart';
import 'package:takemeals/models/order_model.dart';
import 'package:takemeals/utils/constants.dart';
import 'package:takemeals/utils/entrypoint.dart';

class PaymentConfirmedScreen extends StatelessWidget {
  final Order order;

  const PaymentConfirmedScreen({Key? key, required this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const EntryPoint(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Success Icon
            Icon(
              Icons.check_circle,
              color: primaryColor,
              size: 80,
            ),
            SizedBox(height: 16),
            // Confirmation Text
            Text(
              'Payment Confirmed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              'Your order done successfully!',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 24),
            // Receipt-like Information Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Takemeals',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 8),
                  _buildReceiptRow('Order Number', order.orderNumber!),
                  _buildReceiptRow('Name', order.user!.name!),
                  _buildReceiptRow('Payment Method', order.paymentMethod!),
                  _buildReceiptRow('Date', '${order.createdAt!.day}-${order.createdAt!.month}-${order.createdAt!.year}'),
                  _buildReceiptRow('Amount', 'Rp ${order.totalPrice}'),
                ],
              ),
            ),
            const Spacer(),
            // Show QR Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Show QR',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create receipt rows
  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.black54)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
