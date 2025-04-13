// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class StateLifecycleTestRoute extends StatefulWidget {
  final int initValue;
  const StateLifecycleTestRoute({super.key, this.initValue = 0});

  @override
  State<StateLifecycleTestRoute> createState() =>
      _StateLifecycleTestRouteState();
}

class _StateLifecycleTestRouteState extends State<StateLifecycleTestRoute> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // 初始化状态
    _counter = widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => setState(() => ++_counter),
          child: Text("$_counter"),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(StateLifecycleTestRoute oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget ");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
