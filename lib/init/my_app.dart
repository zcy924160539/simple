import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple/pages/home/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(360, 690), // 设计尺寸
      minTextAdapt: true, // 小文本适应
      splitScreenMode: true, // 分屏模式
      child: GetMaterialApp(
        // routes: ,
        title: 'Simple',
        home: HomePage(),
      ),
    );
  }
}
