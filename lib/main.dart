import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CornerConfig(),
      child: const MyApp(),
    ),
  );
}

class CornerConfig extends ChangeNotifier {
  double _topLeft = 20;
  double _topRight = 20;
  double _bottomLeft = 20;
  double _bottomRight = 20;

  double get topLeft => _topLeft;
  double get topRight => _topRight;
  double get bottomLeft => _bottomLeft;
  double get bottomRight => _bottomRight;

  void setTopLeft(double value) {
    _topLeft = value;
    notifyListeners();
  }

  void setTopRight(double value) {
    _topRight = value;
    notifyListeners();
  }

  void setBottomLeft(double value) {
    _bottomLeft = value;
    notifyListeners();
  }

  void setBottomRight(double value) {
    _bottomRight = value;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 11 Variant 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ConfigScreen(),
    );
  }
}

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blue container configurator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Expanded(
              child: Center(
                child: BlueContainerPreview(),
              ),
            ),
            SizedBox(height: 24),
            SliderSection(),
          ],
        ),
      ),
    );
  }
}

class BlueContainerPreview extends StatelessWidget {
  const BlueContainerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.watch<CornerConfig>();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(config.topLeft),
          topRight: Radius.circular(config.topRight),
          bottomLeft: Radius.circular(config.bottomLeft),
          bottomRight: Radius.circular(config.bottomRight),
        ),
      ),
    );
  }
}

class SliderSection extends StatelessWidget {
  const SliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.watch<CornerConfig>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Top-left radius: ${config.topLeft.toStringAsFixed(0)}'),
        Slider(
          min: 0,
          max: 75,
          value: config.topLeft,
          onChanged: (value) =>
              context.read<CornerConfig>().setTopLeft(value),
        ),
        const SizedBox(height: 12),

        Text('Top-right radius: ${config.topRight.toStringAsFixed(0)}'),
        Slider(
          min: 0,
          max: 75,
          value: config.topRight,
          onChanged: (value) =>
              context.read<CornerConfig>().setTopRight(value),
        ),
        const SizedBox(height: 12),

        Text('Bottom-left radius: ${config.bottomLeft.toStringAsFixed(0)}'),
        Slider(
          min: 0,
          max: 75,
          value: config.bottomLeft,
          onChanged: (value) =>
              context.read<CornerConfig>().setBottomLeft(value),
        ),
        const SizedBox(height: 12),

        Text('Bottom-right radius: ${config.bottomRight.toStringAsFixed(0)}'),
        Slider(
          min: 0,
          max: 75,
          value: config.bottomRight,
          onChanged: (value) =>
              context.read<CornerConfig>().setBottomRight(value),
        ),
      ],
    );
  }
}
