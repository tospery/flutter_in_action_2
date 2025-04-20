import 'package:flutter/material.dart';

class IconFontsRoute extends StatelessWidget {
  const IconFontsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ICON")),
      body: Center(
        child: Column(
          children: [
            const Icon(Icons.error, color: Colors.red),
            Text(
              '\uE287' * 20,
              style: const TextStyle(
                fontFamily: "MaterialIcons",
                fontSize: 24.0,
                color: Colors.green,
              ),
            ),
            showIcons(),
          ],
        ),
      ),
    );
  }

  Widget showIcons() {
    String icons = "";
    // accessible: 0xe03e
    icons += "\uE03e";
    // error:  0xe237
    icons += " \uE237";
    // fingerprint: 0xe287
    icons += " \uE287";

    return Text(
      icons,
      style: const TextStyle(
        fontFamily: "MaterialIcons",
        fontSize: 24.0,
        color: Colors.green,
      ),
    );
  }
}
