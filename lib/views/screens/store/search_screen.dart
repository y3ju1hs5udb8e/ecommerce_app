import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/product/filter_provider.dart';
import 'package:project/views/widgets/size.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filterProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: sizePadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find your product',
                textAlign: TextAlign.left,
                style: ThemeText.heading2,
              ),
              heightBox(),
              TextField(
                onChanged: (value) {
                  ref.read(filterProvider.notifier).searchProduct(title: value);
                },
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  hintText: 'Product Name',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_alt),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              heightBox(),
              state.when(
                data: (data) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: (data as List).length,
                      itemBuilder: (context, index) {
                        final prod = data[index];
                        return Container(
                          width: double.infinity,
                          height: 150.h,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.kMainColor),
                            borderRadius: BorderRadius.circular(11.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          prod.title,
                                          style: ThemeText.heading2.copyWith(
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        prod.category.name,
                                        style: ThemeText.heading3.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      Text(
                                        '\$ ${prod.price}',
                                        style: ThemeText.heading2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              CachedNetworkImage(
                                imageUrl: prod.images[0],
                                width: 150.w,
                                height: double.infinity,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ],
                          ),
                        );
                      },
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
            ],
          ),
        ),
      ),
    );
  }
}
