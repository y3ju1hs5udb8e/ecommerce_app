import 'dart:async';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/cart/cart_provider.dart';
import 'package:project/logic/user/auth/auth_provider.dart';
import 'package:project/logic/user/user_provider.dart';
import 'package:project/views/screens/others/admin/product_upload_screen.dart';
import 'package:project/views/screens/others/all_category_screen.dart';
import 'package:project/views/screens/others/profile_edit_screeen.dart';
import 'package:project/views/screens/others/profile_screen.dart';
import 'package:project/views/screens/others/setting_screen.dart';
import 'package:project/views/screens/store/cart_screen.dart';
import 'package:project/views/screens/store/home_screen.dart';
import 'package:project/views/screens/store/search_screen.dart';
import 'package:project/views/widgets/drawer_widgets.dart';
import 'package:project/views/widgets/size.dart';

class RootScreen extends ConsumerStatefulWidget {
  static const String routeName = 'root';
  const RootScreen({super.key});

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  int pageIndex = 0;

  void changeIndex(index) {
    setState(() {
      pageIndex = index;
    });
  }

  //connection status
  late StreamSubscription stream;
  bool isConnected = false; //is connected to internet
  bool isAlerted = false; //is alert box open??

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  void checkInternet() {
    stream = Connectivity().onConnectivityChanged.listen((internet) async {
      isConnected = await InternetConnectionChecker().hasConnection;
      if (!isConnected && isAlerted == false) {
        showDialogBox();
        setState(() => isAlerted = true);
      }
    });
  }

  showDialogBox() => showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('No Internet Connection'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                heightBox(height: -10),
                Icon(
                  Icons.signal_wifi_off,
                  size: 45.sp,
                  color: Colors.grey,
                ),
                Text(
                  'No Internet Connection',
                  style: ThemeText.heading3.copyWith(fontSize: 21.sp),
                ),
                heightBox(height: -10),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() => isAlerted = false);
                  isConnected = await InternetConnectionChecker().hasConnection;
                  if (!isConnected) {
                    showDialogBox();
                    setState(() => isAlerted = true);
                  }
                },
                child: Text(
                  'Retry',
                  style: ThemeText.heading4,
                ),
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final cart = ref.watch(cartProvider);
    return user.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (pageIndex == 3)
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ProfileEditScreen.routeName);
                  },
                  icon: const Icon(Icons.edit),
                ),
            ],
          ),
          drawer: Drawer(
            child: Padding(
              padding: sizePadding(),
              child: Column(
                children: [
                  heightBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundImage: NetworkImage(data.avatar),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          heightBox(),
                          Text(
                            data.name,
                            style: ThemeText.heading2,
                          ),
                          Text(
                            data.email,
                            style: ThemeText.heading3.copyWith(fontSize: 22),
                          ),
                        ],
                      ),
                    ],
                  ),
                  heightBox(height: 15),
                  Column(
                    children: [
                      drawerCard(
                        text: 'Home',
                        callback: () {
                          Navigator.pop(context);
                          setState(() {
                            pageIndex = 0;
                          });
                        },
                        icon: Icons.home,
                      ),
                      heightBox(),
                      drawerCard(
                        text: 'Categories',
                        callback: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, AllCategoryScreen.routeName);
                        },
                        icon: Icons.category,
                      ),
                      heightBox(),
                      data.role == 'admin' || data.role == 'Admin'
                          ? Column(
                              children: [
                                drawerCard(
                                  text: 'Post Porduct',
                                  callback: () {},
                                  icon: Icons.post_add,
                                ),
                                heightBox(),
                                drawerCard(
                                  text: 'Graph',
                                  callback: () {},
                                  icon: Icons.graphic_eq_outlined,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                drawerCard(
                                  text: 'Cart',
                                  callback: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      pageIndex = 1;
                                    });
                                  },
                                  icon: Icons.shopping_bag,
                                ),
                                heightBox(),
                                drawerCard(
                                  text: 'Invite',
                                  callback: () {},
                                  icon: Icons.people_outline,
                                ),
                              ],
                            ),
                      heightBox(),
                      drawerCard(
                        text: 'Setting',
                        callback: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, SettingScreen.routeName);
                        },
                        icon: Icons.settings,
                      ),
                      heightBox(),
                      drawerCard(
                        text: 'About',
                        callback: () {},
                        icon: Icons.info,
                      ),
                    ],
                  ),
                  const Spacer(),
                  drawerCard(
                    text: 'Signout',
                    callback: () {
                      ref.read(authProvider.notifier).logOut();
                    },
                    icon: Icons.exit_to_app,
                  ),
                  heightBox(height: 10),
                ],
              ),
            ),
          ),
          body: <Widget>[
            const HomeScreen(),
            data.role == 'admin' || data.role == 'Admin'
                ? const ProductUploadScreen()
                : const CartScreen(),
            const SearchScreen(),
            const ProfileScreen(),
          ][pageIndex],
          bottomNavigationBar: BottomNavyBar(
            iconSize: 25.sp,
            selectedIndex: pageIndex,
            onItemSelected: changeIndex,
            itemCornerRadius: 30.r,
            containerHeight: 75.h,
            items: [
              BottomNavyBarItem(
                icon: const Icon(CupertinoIcons.home),
                title: const Text('Home'),
                activeColor: AppColor.kMainColor,
              ),
              data.role == 'admin' || data.role == 'Admin'
                  ? BottomNavyBarItem(
                      icon: const Icon(CupertinoIcons.add),
                      title: const Text('Publish'),
                      activeColor: AppColor.kMainColor,
                    )
                  : BottomNavyBarItem(
                      icon: Badge(
                        label: Text(cart.length.toString()),
                        child: const Icon(CupertinoIcons.cart),
                      ),
                      title: const Text('Cart'),
                      activeColor: AppColor.kMainColor,
                    ),
              BottomNavyBarItem(
                icon: const Icon(CupertinoIcons.search),
                title: const Text('Search'),
                activeColor: AppColor.kMainColor,
              ),
              BottomNavyBarItem(
                icon: Expanded(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.value!.avatar),
                  ),
                ),
                title: const Text('Profile'),
                activeColor: AppColor.kMainColor,
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
    );
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }
}
