import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:provider/provider.dart';
import 'package:takemeals/models/order_model.dart';
import 'package:takemeals/models/product_model.dart';
import 'package:takemeals/providers/order_provider.dart';
import 'package:takemeals/providers/user_provider.dart';
import 'package:takemeals/services/token_service.dart';
import 'package:takemeals/utils/constants.dart';

class DetailPaymentScreen extends StatefulWidget {
  final Product product;
  final int orderQuantity;

  const DetailPaymentScreen({
    Key? key,
    required this.product,
    required this.orderQuantity,
  }) : super(key: key);

  @override
  State<DetailPaymentScreen> createState() => _DetailPaymentScreenState();
}

class _DetailPaymentScreenState extends State<DetailPaymentScreen> {
  late final MidtransSDK? _midtrans;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initMidtrans();
  }

  void _initMidtrans() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: dot_env.dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
        merchantBaseUrl: dot_env.dotenv.env['BASE_URL'] ?? "",
        colorTheme: ColorTheme(
          colorPrimary: Colors.blue,
          colorPrimaryDark: Colors.blue,
          colorSecondary: Colors.blue,
        ),
      ),
    );
    _midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );

    _midtrans?.setTransactionFinishedCallback((result) {
      print("Transaction Result: ${result.toJson()}");

      if (result.isTransactionCanceled) {
        _showToast("Transaction Canceled", true);
      } else if (result.transactionStatus ==
              TransactionResultStatus.settlement ||
          result.transactionStatus == TransactionResultStatus.capture) {
        _showToast("Transaction Completed", false);
        _processOrder(
          result.paymentType ?? "Midtrans",
        );
      } else {
        _showToast("Transaction Failed", true);
      }
    });
  }

  void _processOrder(String paymentMethod) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final order = Order(
      userId: userProvider.user!.id,
      productId: widget.product.id,
      quantity: widget.orderQuantity,
      totalPrice: widget.product.price! * widget.orderQuantity,
      paymentMethod: paymentMethod,
    );

    await orderProvider.addOrder(context, order);
  }

  void _showToast(String msg, bool isError) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
    );
  }

  void _startPayment() async {
    if (_midtrans == null) {
      _showToast("Midtrans SDK not initialized", true);
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    final result =
        await TokenService().getToken(widget.product, widget.orderQuantity);

    if (result.isRight()) {
      String? token = result.fold((l) => null, (r) => r.token);

      if (token == null) {
        _showToast('Failed to retrieve token', true);
        setState(() {
          _isProcessing = false;
        });
        return;
      }

      _midtrans?.startPaymentUiFlow(token: token);
    } else {
      _showToast('Transaction Failed', true);
    }

    setState(() {
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.product.price! * widget.orderQuantity;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail Payment',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pickup Details Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.timer, color: Colors.red),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pick Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '${widget.product.partner!.openAt!} - ${widget.product.partner!.closeAt!}',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: Colors.orange),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pick up from',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(
                            width: 280,
                            child: Text(
                              widget.product.partner!.address!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          const Text(
                            '1.3 km away',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 140,
                            child: CupertinoButton(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.near_me_rounded,
                                      color: Colors.black),
                                  SizedBox(width: 8),
                                  Text(
                                    'Direction',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Order Summary Section
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.orderQuantity}x',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.product.name!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Text(
                  'Rp. ${widget.product.price}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sub total',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                Text(
                  'Rp. ${widget.product.price! * widget.orderQuantity}',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fee',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                Text(
                  'Rp 1.000',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1, color: Colors.black54),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  'Rp ${totalPrice}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            // Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                ),
                child: _isProcessing
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : const Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
