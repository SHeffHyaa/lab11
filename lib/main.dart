import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContainerConfig(),
      child: const MyApp(),
    ),
  );
}

/// ----- МОДЕЛЬ СТАНУ ДЛЯ PROVIDER -----
class ContainerConfig extends ChangeNotifier {
  double _width = 150;
  double _height = 150;
  double _topRightRadius = 20;

  double get width => _width;
  double get height => _height;
  double get topRightRadius => _topRightRadius;

  void setWidth(double value) {
    _width = value;
    notifyListeners();
  }

  void setHeight(double value) {
    _height = value;
    notifyListeners();
  }

  void setTopRightRadius(double value) {
    _topRightRadius = value;
    notifyListeners();
  }
}

/// ----- ROOT-ВІДЖЕТ -----
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 11 Provider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const ConfigScreen(),
    );
  }
}

/// ----- ГОЛОВНИЙ ЕКРАН -----
class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container configurator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // прев'ю контейнера
            const Expanded(
              child: Center(
                child: RedContainerPreview(),
              ),
            ),

            const SizedBox(height: 24),

            // секція зі слайдерами
            const SliderSection(),
          ],
        ),
      ),
    );
  }
}

/// ----- КАСТОМНИЙ ВІДЖЕТ: ЧЕРВОНИЙ КОНТЕЙНЕР -----
class RedContainerPreview extends StatelessWidget {
  const RedContainerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.watch<ContainerConfig>();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: config.width,
      height: config.height,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(config.topRightRadius),
        ),
      ),
    );
  }
}

/// ----- КАСТОМНИЙ ВІДЖЕТ: СЕКЦІЯ ЗІ СЛАЙДЕРАМИ -----
class SliderSection extends StatelessWidget {
  const SliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.watch<ContainerConfig>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Width: ${config.width.toStringAsFixed(0)}'),
        Slider(
          min: 50,
          max: 300,
          value: config.width,
          onChanged: (value) =>
              context.read<ContainerConfig>().setWidth(value),
        ),
        const SizedBox(height: 12),

        Text('Height: ${config.height.toStringAsFixed(0)}'),
        Slider(
          min: 50,
          max: 300,
          value: config.height,
          onChanged: (value) =>
              context.read<ContainerConfig>().setHeight(value),
        ),
        const SizedBox(height: 12),

        Text('Top-right radius: ${config.topRightRadius.toStringAsFixed(0)}'),
        Slider(
          min: 0,
          max: 150,
          value: config.topRightRadius,
          onChanged: (value) =>
              context.read<ContainerConfig>().setTopRightRadius(value),
        ),
      ],
    );
  }
}
