import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/logic/product/category_provider.dart';
import 'package:project/logic/user/user_provider.dart';
import 'package:project/views/screens/others/admin/category_upload_screen.dart';
import 'package:project/views/widgets/category_card.dart';
import 'package:project/views/widgets/size.dart';

class AllCategoryScreen extends ConsumerWidget {
  static const String routeName = 'category';
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All categories'),
        actions: [
          if (user.value!.role == 'admin' || user.value!.role == 'Admin')
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CategoryUploadScreen.routeName);
              },
              icon: const Icon(Icons.create),
            ),
        ],
      ),
      body: categories.when(
        data: (data) {
          return SingleChildScrollView(
            padding: sizePadding(),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 15.h,
              spacing: 15.w,
              children: [
                for (final result in data)
                  CategoryCard(
                    data: result,
                    key: UniqueKey(),
                  ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
