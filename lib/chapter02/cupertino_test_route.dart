import 'package:flutter/cupertino.dart';

class CupertinoTestRoute extends StatelessWidget {
  const CupertinoTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          onPressed: () {},
          child: const Text("Press"),
        ),
      ),
    );
  }
}
