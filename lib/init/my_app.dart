import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple/pages/home/home_view.dart';
import 'package:simple/router/app_pages.dart';
import 'package:simple/router/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // 设计尺寸
      minTextAdapt: true, // 小文本适应
      splitScreenMode: true, // 分屏模式
      child: GetMaterialApp(
        title: 'Simple',
        home: const HomePage(),
        initialRoute: Routes.HOME,
        getPages: AppPages.pages,
      ),
    );
  }
}
