import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'next_bloc.dart';
import 'next_event.dart';
import 'next_state.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NextBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<NextBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('next'),
      ),
      body: BlocBuilder<NextBloc, NextState>(
        builder: (context, state) {
          return Center(
            child: GestureDetector(
              onTap: () => {Get.back()},
              child: const Text('next page'),
            ),
          );
        },
      ),
    );
  }
}
