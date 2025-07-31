import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple/enum/count_change_type.dart';
import 'package:dio/dio.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

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
                // 发请求
                _request(),
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

  _request() {
    return GestureDetector(
      onTap: _getRes,
      child: const Text('getRes'),
    );
  }

  _getRes() async {
    Dio dio = Dio();
    Response response = await dio.post(
      'https://slwl-api.itheima.net/driver/driver/login/account',
      data: {
        "account": "xbsj001",
        "password": "123456",
      },
    );
    print(response);
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
