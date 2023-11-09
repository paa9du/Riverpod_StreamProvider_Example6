import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_6_stream_provider/counterdemo.dart';

final counterProvider =
    StateNotifierProvider.autoDispose<CounterDemo, int>((ref) {
  // ref.keepAlive();
  //particular
  final link = ref.keepAlive();
  final timer = Timer(Duration(seconds: 10), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  return CounterDemo();
});

class Counter extends ConsumerWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("counter"),
      ),
      body: Center(
        child: Text('$counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
