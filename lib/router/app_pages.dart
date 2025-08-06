import 'package:get/get.dart';
import 'package:simple/pages/home/home_view.dart';
import 'package:simple/pages/next/next_view.dart';
import 'package:simple/router/routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.NEXT,
      page: () => const NextPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
