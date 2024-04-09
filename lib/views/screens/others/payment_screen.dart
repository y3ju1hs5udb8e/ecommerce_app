import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/cart/cart_provider.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/message_snackbar.dart';
import 'package:project/views/widgets/size.dart';

class PaymentScreen extends StatefulWidget {
  final double price;
  final String name;
  const PaymentScreen({
    super.key,
    required this.price,
    required this.name,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  //geo locator

  String location = '';

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      location = position.altitude.toString();
    }
  }

  @override
  void initState() {
    _nameController.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: sizePadding(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Reciver',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter recivers name';
                  }
                  return null;
                },
              ),
              heightBox(height: -5),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter card number';
                  }
                  return null;
                },
              ),
              heightBox(height: -5),
              TextFormField(
                controller: _expiryDateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
              heightBox(height: -5),
              TextFormField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),
              heightBox(height: -5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location: $location',
                    style: ThemeText.heading3,
                  ),
                  IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: () {
                      getLocation();
                    },
                  ),
                ],
              ),
              heightBox(height: 12),
              Center(
                child: commonButton(
                  callback: () {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState?.validate() ?? false) {
                      _showPaymentConfirmationDialog(context);
                    } else {
                      errorSnackBar(
                        context: context,
                        text: 'Please insert the detail',
                        time: 3,
                      );
                    }
                  },
                  text: 'Pay Now',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Name: ${_nameController.text}',
                style: ThemeText.heading3.copyWith(fontSize: 21.sp),
              ),
              Text(
                'Total Price: ${widget.price}',
                style: ThemeText.heading3.copyWith(fontSize: 21.sp),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel payment
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            Consumer(builder: (context, ref, child) {
              return TextButton(
                onPressed: () {
                  // Handle payment
                  //if payment success in api
                  Navigator.of(context).pop();
                  ref.invalidate(cartProvider);
                  messageSnackBox(
                    context: context,
                    text: 'Payment success',
                    time: 3,
                  );
                  Navigator.pushReplacementNamed(context, RootScreen.routeName);

                  //esle show snack bar here using if else
                },
                child: const Text('Pay'),
              );
            }),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _cardNumberController.dispose();
    _cvvController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }
}
