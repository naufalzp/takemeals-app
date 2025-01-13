import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:takemeals/providers/order_provider.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // QR Scanner
          MobileScanner(
            onDetect: (capture) async {
              if (isProcessing) return;

              setState(() {
                isProcessing = true;
              });

              final String? code = capture.barcodes.first.rawValue;
              if (code != null) {
                final orderNumber = code;
                final orderProvider = Provider.of<OrderProvider>(context, listen: false);
                await orderProvider.confirmOrder(orderNumber);

                if (context.mounted) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Dialog.fullscreen(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 100,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Order Confirmed!',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.green),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Order Number: $orderNumber',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                              Navigator.pop(context); // Navigate back to the previous screen
                            },
                            child: const Text('Back to Home'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }

              setState(() {
                isProcessing = false;
              });
            },
          ),
          // Overlay with Box
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.black.withOpacity(0.7), width: 235),
                  vertical: BorderSide(color: Colors.black.withOpacity(0.7), width: 50),
                ),
              ),
            ),
          ),
          // Hint Text
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Text(
              'Align QR code within the box to scan',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
