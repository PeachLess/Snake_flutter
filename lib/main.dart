import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/snake.dart';
import 'widgets/buttons.dart';
import './widgets/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Snake'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    double size = isLandscape ? mediaQuery.size.height : mediaQuery.size.width;
    final appBar = AppBar(
      title: Text(widget.title),
    );
    final content = [
      Container(
        width: size,
        height: size,
        child: const Screen(),
      ),
      const Expanded(child: Buttons())
    ];

    return ChangeNotifierProvider(
      create: ((context) => Snake()),
      child: Scaffold(
        appBar: appBar,
        body: isLandscape
            ? Row(children: content)
            : Column(
                children: content,
              ),
      ),
    );
  }
}
