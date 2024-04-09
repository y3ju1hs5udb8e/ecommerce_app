import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/logic/product/products_provider.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/form_widget.dart';
import 'package:project/views/widgets/size.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel data;
  const UpdateScreen({
    super.key,
    required this.data,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.data.title);
    descriptionController =
        TextEditingController(text: widget.data.description);
    priceController = TextEditingController(text: widget.data.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update product detail'),
      ),
      body: SingleChildScrollView(
        padding: sizePadding(),
        child: Column(
          children: [
            formField(
              controller: titleController,
              text: 'Title',
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
            ),
            heightBox(),
            formField(
              controller: priceController,
              text: 'Product Cost',
              isInt: true,
            ),
            heightBox(),
            Consumer(builder: (context, ref, child) {
              return commonButton(
                callback: () {
                  FocusScope.of(context).unfocus();
                  ref.read(productProvider.notifier).updateProduct(
                        id: widget.data.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        price: int.parse(priceController.text),
                      );

                  Navigator.pushReplacementNamed(context, RootScreen.routeName);
                },
                text: 'Update edit',
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
  }
}
