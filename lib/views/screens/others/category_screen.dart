import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/product/filter_provider.dart';
import 'package:project/views/widgets/product_card.dart';
import 'package:project/views/widgets/size.dart';

class CategoryScreen extends ConsumerWidget {
  final int id;
  final String title;
  const CategoryScreen({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(catItemProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: category.when(
        data: (data) {
          return data.isEmpty
              ? Center(
                  child: Text(
                    'Not product available',
                    style: ThemeText.heading2,
                  ),
                )
              : SingleChildScrollView(
                  padding: sizePadding(),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    runSpacing: 15.h,
                    spacing: 15.w,
                    children: [
                      for (final result in data)
                        ProductCard(
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
