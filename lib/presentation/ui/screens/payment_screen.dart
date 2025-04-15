import 'package:cartzy/presentation/ui/utils/assets_path.dart';
import 'package:cartzy/presentation/ui/utils/snack_massage.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.totalPrice});

  final String totalPrice;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    String totalPrice=widget.totalPrice??'';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Method',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){showSnackBarMassage('!! Will be added this option !! Your Bill $totalPrice');},
              child: Image.asset(
                AssetsPath.bkash,
                width: 180,
                height: 130,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: (){showSnackBarMassage('!! Will be added this option !! Your Bill $totalPrice');},
              child: Image.asset(
                AssetsPath.nagad,
                width: 180, 
                height: 130, 
                fit: BoxFit.scaleDown, 
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: (){showSnackBarMassage('!! Will be added this option !! Your Bill $totalPrice');},
              child: Image.asset(
                AssetsPath.roket,
                width: 180, 
                height: 130, 
                fit: BoxFit.scaleDown, 
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: (){showSnackBarMassage('!! Will be added this option !! Your Bill $totalPrice');},
              child: Image.asset(
                AssetsPath.crypto,
                width: 180, 
                height: 130, 
                fit: BoxFit.scaleDown, 
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: (){showSnackBarMassage('!! Will be added this option !! Your Bill $totalPrice');},
              child: Image.asset(
                AssetsPath.card,
                width: 180, 
                height: 130, 
                fit: BoxFit.scaleDown, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
