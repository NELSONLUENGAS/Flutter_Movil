import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedScreen
    extends StatefulWidget {
  static const name = 'animated';
  static const route = '/animated';

  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() =>
      _AnimatedScreenState();
}

class _AnimatedScreenState
    extends State<AnimatedScreen> {
  // ---------- Estados para cada animación ----------
  // AnimatedContainer
  double containerWidth = 100;
  double containerHeight = 100;
  Color containerColor = Colors.indigo;
  double containerBorderRadius = 20;

  // AnimatedOpacity
  double opacity = 1.0;

  // AnimatedPadding
  double paddingValue = 8.0;

  // AnimatedAlign
  AlignmentGeometry alignment =
      Alignment.center;
  final List<AlignmentGeometry>
  alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  // AnimatedPositioned (dentro de un Stack)
  double positionedLeft = 0;
  double positionedTop = 0;
  double positionedWidth = 60;
  double positionedHeight = 60;

  // AnimatedCrossFade
  bool showFirst = true;

  // AnimatedSwitcher
  int switcherIndex = 0;
  final List<IconData> switcherIcons = [
    Icons.favorite,
    Icons.star,
    Icons.thumb_up,
    Icons.mood,
  ];

  // AnimatedRotation
  double rotationAngle = 0.0;

  // AnimatedScale
  double scaleFactor = 1.0;

  // Utilidades
  final random = Random();

  // ---------- Métodos para randomizar ----------
  void randomizeContainer() {
    setState(() {
      containerWidth =
          50 +
          random
              .nextInt(150)
              .toDouble();
      containerHeight =
          50 +
          random
              .nextInt(150)
              .toDouble();
      containerColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      containerBorderRadius = random
          .nextInt(50)
          .toDouble();
    });
  }

  void randomizeOpacity() {
    setState(() {
      opacity =
          0.3 +
          random.nextDouble() *
              0.7; // entre 0.3 y 1.0
    });
  }

  void randomizePadding() {
    setState(() {
      paddingValue =
          4 +
          random
              .nextInt(32)
              .toDouble(); // entre 4 y 36
    });
  }

  void randomizeAlignment() {
    setState(() {
      alignment =
          (alignments..shuffle()).first;
    });
  }

  void randomizePositioned() {
    setState(() {
      // El Stack tiene tamaño 200x200, el cuadro 60x60, así que máximo left/top = 140
      positionedLeft = random
          .nextInt(141)
          .toDouble();
      positionedTop = random
          .nextInt(141)
          .toDouble();
    });
  }

  void toggleCrossFade() {
    setState(() {
      showFirst = !showFirst;
    });
  }

  void randomizeSwitcher() {
    setState(() {
      switcherIndex =
          (switcherIndex + 1) %
          switcherIcons.length;
    });
  }

  void randomizeRotation() {
    setState(() {
      rotationAngle =
          random.nextDouble() *
          2 *
          pi; // 0 a 2π
    });
  }

  void randomizeScale() {
    setState(() {
      scaleFactor =
          0.5 +
          random.nextDouble() *
              1.5; // entre 0.5 y 2.0
    });
  }

  // Randomiza todas las animaciones
  void randomizeAll() {
    randomizeContainer();
    randomizeOpacity();
    randomizePadding();
    randomizeAlignment();
    randomizePositioned();
    toggleCrossFade(); // alterna el crossfade
    randomizeSwitcher();
    randomizeRotation();
    randomizeScale();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Animated Screen',
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary,
                colors.secondary,
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
            onPressed: randomizeAll,
            child: const Icon(
              Icons.shuffle_rounded,
            ),
          ),
      body: ListView(
        padding: const EdgeInsets.all(
          16,
        ),
        children: [
          // ---------- AnimatedContainer ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedContainer',
                  ),
                  subtitle: Text(
                    'Ancho: ${containerWidth.toStringAsFixed(0)} · Alto: ${containerHeight.toStringAsFixed(0)} · Borde: ${containerBorderRadius.toStringAsFixed(0)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        randomizeContainer,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Center(
                    child: AnimatedContainer(
                      duration:
                          const Duration(
                            milliseconds:
                                400,
                          ),
                      curve: Curves
                          .easeInOut,
                      width:
                          containerWidth,
                      height:
                          containerHeight,
                      decoration: BoxDecoration(
                        color:
                            containerColor,
                        borderRadius:
                            BorderRadius.circular(
                              containerBorderRadius,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ---------- AnimatedOpacity ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedOpacity',
                  ),
                  subtitle: Text(
                    'Opacidad: ${opacity.toStringAsFixed(2)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        randomizeOpacity,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Center(
                    child: AnimatedOpacity(
                      duration:
                          const Duration(
                            milliseconds:
                                400,
                          ),
                      opacity: opacity,
                      child: Container(
                        width: 100,
                        height: 100,
                        color:
                            Colors.blue,
                      ),
                    ),
                  ),
                ),
                // Slider para control manual
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                  child: Row(
                    children: [
                      const Text('0.0'),
                      Expanded(
                        child: Slider(
                          value:
                              opacity,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (v) =>
                              setState(
                                () => opacity =
                                    v,
                              ),
                        ),
                      ),
                      const Text('1.0'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ---------- AnimatedPadding ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedPadding',
                  ),
                  subtitle: Text(
                    'Padding: ${paddingValue.toStringAsFixed(0)} px',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        randomizePadding,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Center(
                    child: Container(
                      color: Colors
                          .grey[300],
                      child: AnimatedPadding(
                        duration:
                            const Duration(
                              milliseconds:
                                  400,
                            ),
                        padding:
                            EdgeInsets.all(
                              paddingValue,
                            ),
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors
                              .green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                  child: Row(
                    children: [
                      const Text('4'),
                      Expanded(
                        child: Slider(
                          value:
                              paddingValue,
                          min: 4,
                          max: 40,
                          onChanged: (v) =>
                              setState(
                                () => paddingValue =
                                    v,
                              ),
                        ),
                      ),
                      const Text('40'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ---------- AnimatedAlign ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedAlign',
                  ),
                  subtitle: const Text(
                    'Toca el dado para cambiar alineación',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        randomizeAlignment,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Container(
                    width:
                        double.infinity,
                    height: 200,
                    color: Colors
                        .grey[300],
                    child: AnimatedAlign(
                      duration:
                          const Duration(
                            milliseconds:
                                400,
                          ),
                      alignment:
                          alignment,
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors
                            .purple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ---------- AnimatedPositioned (dentro de Stack) ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedPositioned',
                  ),
                  subtitle: Text(
                    'Left: ${positionedLeft.toStringAsFixed(0)} · Top: ${positionedTop.toStringAsFixed(0)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        randomizePositioned,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors
                          .grey[300],
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(
                              milliseconds:
                                  400,
                            ),
                            left:
                                positionedLeft,
                            top:
                                positionedTop,
                            width:
                                positionedWidth,
                            height:
                                positionedHeight,
                            child: Container(
                              color: Colors
                                  .orange,
                              child: const Center(
                                child: Text(
                                  'Mueve',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ---------- AnimatedCrossFade ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedCrossFade',
                  ),
                  subtitle: Text(
                    showFirst
                        ? 'Mostrando Widget A'
                        : 'Mostrando Widget B',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        toggleCrossFade,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Center(
                    child: AnimatedCrossFade(
                      duration:
                          const Duration(
                            milliseconds:
                                400,
                          ),
                      firstChild: Container(
                        width: 120,
                        height: 120,
                        color:
                            Colors.red,
                        child:
                            const Center(
                              child:
                                  Text(
                                    'A',
                                  ),
                            ),
                      ),
                      secondChild: Container(
                        width: 120,
                        height: 120,
                        color:
                            Colors.blue,
                        child:
                            const Center(
                              child:
                                  Text(
                                    'B',
                                  ),
                            ),
                      ),
                      crossFadeState:
                          showFirst
                          ? CrossFadeState
                                .showFirst
                          : CrossFadeState
                                .showSecond,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ---------- AnimatedSwitcher ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedSwitcher',
                  ),
                  subtitle: Text(
                    'Icono actual: ${switcherIcons[switcherIndex].toString()}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        randomizeSwitcher,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration:
                          const Duration(
                            milliseconds:
                                400,
                          ),
                      transitionBuilder:
                          (
                            child,
                            animation,
                          ) {
                            return ScaleTransition(
                              scale:
                                  animation,
                              child:
                                  child,
                            );
                          },
                      child: Icon(
                        switcherIcons[switcherIndex],
                        key: ValueKey(
                          switcherIndex,
                        ),
                        size: 80,
                        color:
                            Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ---------- AnimatedRotation ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedRotation',
                  ),
                  subtitle: Text(
                    'Ángulo: ${(rotationAngle * 180 / pi).toStringAsFixed(0)}°',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        randomizeRotation,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Center(
                    child: AnimatedRotation(
                      duration:
                          const Duration(
                            milliseconds:
                                400,
                          ),
                      turns:
                          rotationAngle /
                          (2 *
                              pi), // AnimatedRotation usa turns (1 vuelta = 2π)
                      child: Container(
                        width: 80,
                        height: 80,
                        color:
                            Colors.pink,
                        child: const Icon(
                          Icons
                              .arrow_upward,
                          color: Colors
                              .white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                  child: Row(
                    children: [
                      const Text('0°'),
                      Expanded(
                        child: Slider(
                          value:
                              rotationAngle,
                          min: 0,
                          max: 2 * pi,
                          onChanged: (v) =>
                              setState(
                                () => rotationAngle =
                                    v,
                              ),
                        ),
                      ),
                      const Text(
                        '360°',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ---------- AnimatedScale ----------
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'AnimatedScale',
                  ),
                  subtitle: Text(
                    'Escala: ${scaleFactor.toStringAsFixed(2)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.casino,
                    ),
                    onPressed:
                        randomizeScale,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Center(
                    child: AnimatedScale(
                      duration:
                          const Duration(
                            milliseconds:
                                400,
                          ),
                      scale:
                          scaleFactor,
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors
                            .amber,
                        child: const Icon(
                          Icons.star,
                          color: Colors
                              .black87,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                  child: Row(
                    children: [
                      const Text('0.5'),
                      Expanded(
                        child: Slider(
                          value:
                              scaleFactor,
                          min: 0.5,
                          max: 2.0,
                          onChanged: (v) =>
                              setState(
                                () => scaleFactor =
                                    v,
                              ),
                        ),
                      ),
                      const Text('2.0'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
