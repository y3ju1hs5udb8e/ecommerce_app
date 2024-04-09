import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/core/routes.dart';
import 'package:project/core/themes.dart';
import 'package:project/data/models/cart/cart_model.dart';
import 'package:project/logic/obsorver_provider.dart';
import 'package:project/logic/others/other_providers.dart';
import 'package:project/views/screens/others/status_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //loacal db
  await Hive.initFlutter();
  await Hive.openBox('data');

  //adapters
  Hive.registerAdapter(CartModelAdapter());
  Hive.openBox<CartModel>('cart');

  // //checkig user data
  // final container = ProviderContainer();

  // //using container cause cant access to ref or context
  // final userData = container.read(userProvider.notifier).userDatas;

  // userData.listen((event) {
  //   event.when(
  //     data: (data) => print(data),
  //     error: (e, st) => print('$e : $st'),
  //     loading: () => print('loading'),
  //   );
  // });

  runApp(
    ProviderScope(
      observers: [MyProviderObserver()],
      child: const EcommerceApp(),
    ),
  );
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      designSize: Size(width, height),
      child: Consumer(builder: (context, ref, child) {
        final isLisght = ref.watch(themeProvider);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isLisght ? AppThemes.lightTheme : AppThemes.darkTheme,
          onGenerateRoute: Routes.onGeneratedRoute,
          initialRoute: StatusScreen.routeName,
        );
      }),
    );
  }
}
