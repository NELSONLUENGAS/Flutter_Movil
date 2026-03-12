import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressScreen
    extends StatefulWidget {
  static const name = 'progress';
  static const route = '/progress';

  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() =>
      _ProgressScreenState();
}

class _ProgressScreenState
    extends State<ProgressScreen> {
  double _animatedValue = 0.0;
  Timer? _timer;
  bool _isAnimating = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimation() {
    if (_isAnimating) return;
    _timer?.cancel();
    setState(
      () => _animatedValue = 0.0,
    );
    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        setState(() {
          if (_animatedValue >= 1.0) {
            _isAnimating = false;
            timer.cancel();
            _timer = null;
          } else {
            _animatedValue += 0.01;
          }
        });
      },
    );

    _isAnimating = true;
  }

  void _resetAnimation() {
    _timer?.cancel();
    setState(() {
      _animatedValue = 0.0;
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Progress Indicators',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const _BuildSectionTitle(
              title:
                  'With StreamBuilder',
            ),
            const SizedBox(height: 8),
            _BuildStreamBuilderCard(
              colors: colors,
            ),
            const SizedBox(height: 24),

            const _BuildSectionTitle(
              title:
                  'Linear Progress Indicators',
            ),
            const SizedBox(height: 8),
            const _BuildLinearCard(
              title: 'Indeterminate',
              description:
                  'Indicates that a task is in progress without a specific completion percentage.',
              child:
                  LinearProgressIndicator(),
            ),
            _BuildLinearCard(
              title:
                  'Determinate (70%)',
              description:
                  'Show the progress of a task with a specific completion percentage.',
              child: LinearProgressIndicator(
                value: 0.7,
                backgroundColor:
                    Colors.grey[300],
                valueColor:
                    AlwaysStoppedAnimation<
                      Color
                    >(colors.primary),
              ),
            ),
            _BuildLinearCard(
              title:
                  'With percentage label',
              description:
                  'Displayed progress with a percentage label.',
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.85,
                      backgroundColor:
                          Colors
                              .grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<
                            Color
                          >(
                            colors
                                .secondary,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    '85%',
                    style: TextStyle(
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const _BuildSectionTitle(
              title:
                  'Circular progress indicators',
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                const _BuildCircularCard(
                  title:
                      'Indeterminate',
                  child:
                      CircularProgressIndicator(),
                ),
                _BuildCircularCard(
                  title:
                      'Determinate (60%)',
                  child: CircularProgressIndicator(
                    value: 0.6,
                    backgroundColor:
                        Colors
                            .grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<
                          Color
                        >(
                          colors
                              .primary,
                        ),
                  ),
                ),
                const _BuildCircularCard(
                  title:
                      'With custome size',
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      valueColor:
                          AlwaysStoppedAnimation<
                            Color
                          >(
                            Colors
                                .orange,
                          ),
                    ),
                  ),
                ),

                _BuildCircularCard(
                  title:
                      'With text inside it',
                  child: Stack(
                    alignment: Alignment
                        .center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: 0.75,
                          backgroundColor:
                              Colors
                                  .grey[300],
                          valueColor:
                              AlwaysStoppedAnimation<
                                Color
                              >(
                                Colors
                                    .green,
                              ),
                          strokeWidth:
                              6,
                        ),
                      ),
                      const Text(
                        '75%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _BuildSectionTitle(
              title: 'Other styles',
            ),
            const SizedBox(height: 8),
            const _BuildLinearCard(
              title:
                  'RefreshProgressIndicator (Material 3)',
              description:
                  'Refresh style',
              child: Center(
                child: RefreshProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor:
                      Colors.white,
                  valueColor:
                      AlwaysStoppedAnimation<
                        Color
                      >(Colors.blue),
                ),
              ),
            ),
            const _BuildLinearCard(
              title:
                  'CupertinoActivityIndicator',
              description:
                  'iOS native style',
              child: Center(
                child:
                    CupertinoActivityIndicator(
                      radius: 20,
                    ),
              ),
            ),
            _BuildLinearCard(
              title:
                  'Animated progress indicator (handled)',
              description:
                  'Press the button to start the animation',
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value:
                        _animatedValue,
                    backgroundColor:
                        Colors
                            .grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<
                          Color
                        >(
                          colors
                              .primary,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      ElevatedButton(
                        onPressed:
                            (_isAnimating
                            ? null
                            : _startAnimation),
                        child:
                            const Text(
                              'Start',
                            ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed:
                            _resetAnimation,
                        child:
                            const Text(
                              'Reset',
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const _BuildSectionTitle(
              title: 'Custom styles',
            ),
            const SizedBox(height: 8),
            _BuildLinearCard(
              title:
                  'Circular radial gradient',
              description:
                  'Gradient effect using CustomPainter (simulated)',
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape:
                        BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        colors.primary,
                        colors
                            .secondary,
                        Colors
                            .transparent,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<
                            Color
                          >(
                            Colors
                                .white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildStreamBuilderCard
    extends StatefulWidget {
  final ColorScheme colors;

  const _BuildStreamBuilderCard({
    required this.colors,
  });

  @override
  State<_BuildStreamBuilderCard>
  createState() =>
      _BuildStreamBuilderCardState();
}

class _BuildStreamBuilderCardState
    extends
        State<_BuildStreamBuilderCard> {
  late StreamController<double>
  _downloadController;
  Timer? _downloadTimer;

  @override
  void initState() {
    super.initState();
    _downloadController =
        StreamController<double>();
  }

  @override
  void dispose() {
    _downloadTimer?.cancel();
    _downloadController.close();
    super.dispose();
  }

  void startDownload() {
    _downloadTimer?.cancel();

    if (_downloadController.isClosed) {
      setState(() {
        _downloadController =
            StreamController<double>();
      });
    }
    double progress = 0.0;
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        progress += 0.02;

        if (progress >= 1.0) {
          if (!_downloadController
              .isClosed) {
            _downloadController.add(
              1.0,
            );
            _downloadController.close();
          }
          timer.cancel();
          _downloadTimer = null;
        } else {
          if (!_downloadController
              .isClosed) {
            _downloadController.add(
              progress,
            );
          } else {
            timer.cancel();
            _downloadTimer = null;
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin:
          const EdgeInsets.symmetric(
            vertical: 8,
          ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Simulated download progress using StreamBuilder',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Streambuilder listens to a stream and updates the progress indicator accordingly.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder<double>(
              stream:
                  _downloadController
                      .stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      const Icon(
                        Icons.error,
                        color:
                            Colors.red,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Error: ${snapshot.error}',
                      ),
                    ],
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                final progress =
                    snapshot.data!;
                final isComplete =
                    (progress >= 1.0);

                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor:
                          Colors
                              .grey[300],
                      valueColor: AlwaysStoppedAnimation(
                        isComplete
                            ? Colors
                                  .green
                            : widget
                                  .colors
                                  .primary,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        Text(
                          'Progress: ${(progress * 100).toStringAsFixed(0)}%',
                        ),
                        if (isComplete)
                          const Icon(
                            Icons
                                .check_circle,
                            color: Colors
                                .green,
                          )
                        else if (progress >
                            0)
                          const Icon(
                            Icons
                                .downloading,
                            color: Colors
                                .blue,
                          )
                        else
                          const Icon(
                            Icons
                                .pending,
                            color: Colors
                                .grey,
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                      children: [
                        if (progress <
                                1.0 &&
                            progress >
                                0)
                          ElevatedButton(
                            onPressed: () {
                              /* no hacer nada, ya está en progreso */
                            },
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor:
                                  Colors
                                      .grey,
                            ),
                            child: Text(
                              'Downloading...',
                            ),
                          ),
                        if (progress >=
                                1.0 ||
                            progress ==
                                0.0)
                          ElevatedButton(
                            onPressed:
                                startDownload,
                            child: Text(
                              progress >=
                                      1.0
                                  ? 'Restart'
                                  : 'Start',
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed:
                    startDownload,
                child: const Text(
                  'Start simulated download',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildSectionTitle
    extends StatelessWidget {
  final String title;

  const _BuildSectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        top: 8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _BuildLinearCard
    extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _BuildLinearCard({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin:
          const EdgeInsets.symmetric(
            vertical: 8,
          ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _BuildCircularCard
    extends StatelessWidget {
  final String title;
  final Widget child;

  const _BuildCircularCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          12,
        ),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
