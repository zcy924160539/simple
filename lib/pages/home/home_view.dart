import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple/enum/count_change_type.dart';
import 'package:simple/pages/next/next_view.dart';
import 'package:simple/router/routes.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('home'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (pre, cur) => pre.count != cur.count,
        builder: (context, state) {
          final String countData = state.count.toString();
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(countData),
                // 计算数值
                _computed(context),
                // 跳转去其他页面
                _buildToNextPageBtn(),
              ],
            ),
          );
        },
      ),
    );
  }

  _computed(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button(context, CountChangeType.increment),
        SizedBox(width: 30.w),
        _button(context, CountChangeType.decrement),
      ],
    );
  }

  _buildToNextPageBtn() {
    return GestureDetector(
      onTap: _onTapToNextPage,
      child: const Text('toNextPage'),
    );
  }

  _onTapToNextPage() {
    Get.toNamed(Routes.NEXT);
  }

  _button(BuildContext context, CountChangeType type) {
    return GestureDetector(
      onTap: () => _onTapChange(context: context, type: type),
      child: Text(CountChangeType.format(type.name).name),
    );
  }

  void _onTapChange({required BuildContext context, required CountChangeType type}) {
    BlocProvider.of<HomeBloc>(context).add(OnIncrementEvent(num: 1, type: type));
  }
}
