// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class RouterTestRoute extends StatelessWidget {
  const RouterTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("路由测试")),
      body: Center(
        child: ElevatedButton(
          child: const Text("打开提示页"),
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const TipRoute(text: "我是提示xxxx");
                },
              ),
            );
            print("路由返回值: $result");
          },
        ),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  final String text;

  const TipRoute({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("提示")),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: const Text("返回"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
