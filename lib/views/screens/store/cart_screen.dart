import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/cart/cart_provider.dart';
import 'package:project/logic/user/user_provider.dart';
import 'package:project/views/screens/others/payment_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/size.dart';

class CartScreen extends ConsumerWidget {
  static const String routeName = 'cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: sizePadding(),
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final data = cartItems[index];
                return Container(
                  width: double.infinity,
                  height: 150.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  data.name,
                                  style: ThemeText.heading2.copyWith(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                              Text(
                                data.category,
                                style: ThemeText.heading3.copyWith(
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text(
                                '\$ ${data.price}',
                                style: ThemeText.heading2,
                              ),
                              Text(
                                'Quantity: ${data.number}',
                                style: ThemeText.heading4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(11.r),
                            child: Image.network(
                              width: 150.w,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              data.image,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: -10,
                            child: IconButton(
                              onPressed: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .deleteItem(data.id);
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 35.sp,
                                color: Colors.red.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 35,
            bottom: 5,
            child: commonButton(
              callback: () {
                final price = ref.read(cartProvider.notifier).totalSum();
                final name = ref.watch(userProvider);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      price: price,
                      name: name.value!.name,
                    ),
                  ),
                );
              },
              text: 'Check out',
            ),
          ),
        ],
      ),
    );
  }
}
