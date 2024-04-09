import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/others/other_providers.dart';
import 'package:project/logic/product/category_provider.dart';
import 'package:project/logic/product/products_provider.dart';
import 'package:project/views/screens/others/category_screen.dart';
import 'package:project/views/widgets/banner_widget.dart';
import 'package:project/views/widgets/capsule_widget.dart';
import 'package:project/views/widgets/carousel_widget.dart';
import 'package:project/views/widgets/product_card.dart';
import 'package:project/views/widgets/size.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<String> banners = [
    'banne_one.jpg',
    'banne_two.jpg',
    'banne_three.jpg',
  ];

  final _controller = PageController();

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productProvider);
    // final stream = ref.watch(productProvider.notifier).data;
    final category = ref.watch(categoryProvider);
    final isLight = ref.watch(themeProvider);
    return Scaffold(
      body: product.when(
        data: (data) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: sizePadding(),
            children: [
              //1st banner
              SizedBox(
                height: 200.h,
                width: 400.w,
                child: Stack(
                  children: [
                    BannerWidget(
                      controller: _controller,
                      banners: banners,
                    ),
                    Container(
                      alignment: const Alignment(0, 1.1),
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: banners.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Colors.blue,
                          dotColor: isLight ? Colors.black : Colors.white,
                          radius: 15.r,
                          spacing: 5.w,
                          dotHeight: 10.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              heightBox(height: 5),

              //2nd deals
              Row(
                children: [
                  Text(
                    'Weekly Deals',
                    style: ThemeText.heading2,
                  ),
                  Text(
                    '(25% off)',
                    style: ThemeText.heading4.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              heightBox(),
              CarouselWidget(data: data),
              heightBox(height: 4),

              //category and products
              Text(
                'Categories',
                style: ThemeText.heading3,
              ),
              heightBox(height: -3),
              category.when(
                data: (data) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        capsuleWidget(
                          text: 'All',
                          image:
                              "https://ouch-cdn2.icons8.com/kxESxotVqb6yDvV6ys5GIg_xcR1epKmNfSTQNUvuF1E/rs:fit:368:207/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNDM4/L2E1NjZmNDY0LTE1/MWEtNGFiZi1hN2Vk/LTJiYWEwOWZmOTE4/OC5zdmc.png",
                        ),
                        for (final i in data)
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                    id: i.id,
                                    title: i.name,
                                  ),
                                ),
                              );
                            },
                            child: capsuleWidget(text: i.name, image: i.image),
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
              heightBox(height: 5),

              // products
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 15.h,
                spacing: 5.w,
                children: [
                  for (final i in data)
                    ProductCard(
                      data: i,
                      key: UniqueKey(),
                    ),
                ],
              ),
            ],
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
