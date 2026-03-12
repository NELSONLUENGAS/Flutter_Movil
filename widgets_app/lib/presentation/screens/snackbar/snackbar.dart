import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SnackbarScreen
    extends StatefulWidget {
  static const name = 'snackbars';
  static const route = '/snackbars';

  const SnackbarScreen({super.key});

  @override
  State<SnackbarScreen> createState() =>
      _SnackbarScreenState();
}

class _SnackbarScreenState
    extends State<SnackbarScreen>
    with TickerProviderStateMixin {
  final Set<String> _dontShowAgain =
      <String>{};

  final List<OverlayEntry>
  _activeOverlays = [];
  static const _maxOverlays = 3;

  final _progressTimeNotifier =
      ValueNotifier<double>(0);

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _progressTimeNotifier.dispose();
    for (final entry
        in _activeOverlays) {
      entry.remove();
    }
    super.dispose();
  }

  void _showMultiActionOverlay(
    BuildContext context,
    String message,
    List<String> actions,
  ) {
    if (_activeOverlays.length >=
        _maxOverlays) {
      _activeOverlays
          .removeAt(0)
          .remove();
    }

    final overlay = Overlay.of(context);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius:
                  BorderRadius.circular(
                    8,
                  ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  message,
                  style:
                      const TextStyle(
                        color: Colors
                            .white,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .end,
                  children: actions.map((
                    label,
                  ) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                            left: 8,
                          ),
                      child: TextButton(
                        onPressed: () {
                          entry
                              .remove();
                          _activeOverlays
                              .remove(
                                entry,
                              );
                          final messenger =
                              ScaffoldMessenger.of(
                                context,
                              );

                          messenger
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content:
                                    Text(
                                      'Action $label execute',
                                    ),
                              ),
                            );
                        },
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: Colors
                                .blue,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    _activeOverlays.add(entry);

    Timer(
      const Duration(seconds: 8),
      () {
        if (entry.mounted) {
          entry.remove();
          _activeOverlays.remove(entry);
        }
      },
    );
  }

  void _showHoverSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    bool isHovering = false;
    Timer? autoCloseTimer;

    late final OverlayEntry entry;

    void startTimer() {
      autoCloseTimer?.cancel();

      if (!isHovering) {
        autoCloseTimer = Timer(
          const Duration(seconds: 3),
          () {
            entry.remove();
            _activeOverlays.remove(
              entry,
            );
          },
        );
      }
    }

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: MouseRegion(
          onEnter: (_) {
            isHovering = true;
            autoCloseTimer?.cancel();
          },
          onExit: (_) {
            isHovering = false;
            startTimer();
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding:
                  const EdgeInsets.all(
                    16,
                  ),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius:
                    BorderRadius.circular(
                      8,
                    ),
              ),
              child: const Text(
                'Pasa el mouse para evitar que se cierre (desktop)',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    _activeOverlays.add(entry);
    startTimer();
  }

  void _showDraggableSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    final size = MediaQuery.of(
      context,
    ).size;
    late final OverlayEntry entry;
    ValueNotifier<Offset> position =
        ValueNotifier(
          const Offset(20, 20),
        );

    entry = OverlayEntry(
      builder: (context) => ValueListenableBuilder<Offset>(
        valueListenable: position,
        builder: (context, offset, child) {
          return Positioned(
            left: offset.dx,
            top: offset.dy,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onPanUpdate: (details) {
                  position
                      .value = Offset(
                    max(
                      0,
                      min(
                        size.width -
                            200,
                        position
                                .value
                                .dx +
                            details
                                .delta
                                .dx,
                      ),
                    ),
                    max(
                      0,
                      min(
                        size.width -
                            100,
                        position
                                .value
                                .dx +
                            details
                                .delta
                                .dx,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  padding:
                      const EdgeInsets.all(
                        12,
                      ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius:
                        BorderRadius.circular(
                          8,
                        ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors
                            .black26,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisSize:
                        MainAxisSize
                            .min,
                    children: [
                      Text(
                        'Arrástrame',
                        style: TextStyle(
                          color: Colors
                              .white,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Puedes moverme por la pantalla',
                        style: TextStyle(
                          color: Colors
                              .white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    overlay.insert(entry);
    _activeOverlays.add(entry);

    Timer(
      const Duration(seconds: 15),
      () {
        entry.remove();
        _activeOverlays.remove(entry);
      },
    );
  }

  // Snackbar expandible/colapsable
  void _showExpandableSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    ValueNotifier<bool> expanded =
        ValueNotifier(false);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: ValueListenableBuilder<bool>(
            valueListenable: expanded,
            builder: (context, isExpanded, child) {
              return AnimatedContainer(
                duration:
                    const Duration(
                      milliseconds: 300,
                    ),
                curve: Curves.easeInOut,
                padding:
                    const EdgeInsets.all(
                      16,
                    ),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius:
                      BorderRadius.circular(
                        8,
                      ),
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Notificación',
                            style: TextStyle(
                              color: Colors
                                  .white,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isExpanded
                                ? Icons
                                      .expand_less
                                : Icons
                                      .expand_more,
                            color: Colors
                                .white,
                          ),
                          onPressed: () =>
                              expanded
                                  .value = !expanded
                                  .value,
                        ),
                      ],
                    ),
                    if (isExpanded) ...[
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Aquí hay información adicional que puede ser útil. Puedes mostrar más detalles cuando el usuario expande.',
                        style: TextStyle(
                          color: Colors
                              .white70,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          entry
                              .remove();
                          _activeOverlays
                              .remove(
                                entry,
                              );
                        },
                        child:
                            const Text(
                              'Cerrar',
                            ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
  }

  // Snackbar con imagen y texto
  void _showImageSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.all(
                  12,
                ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                    8,
                  ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                        8,
                      ),
                  child: Image.network(
                    'https://picsum.photos/50/50?random=1',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        'Nueva foto',
                        style: TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                      Text(
                        'Usuario compartió una imagen',
                        style: TextStyle(
                          color: Colors
                              .grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
    Timer(
      const Duration(seconds: 5),
      () {
        entry.remove();
        _activeOverlays.remove(entry);
      },
    );
  }

  // Snackbar con código QR simulado
  void _showQrSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.all(
                  16,
                ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Text(
                  'Escanea el código',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'QR',
                      style: TextStyle(
                        color: Colors
                            .white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Simulación de código QR',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
    Timer(
      const Duration(seconds: 6),
      () {
        entry.remove();
        _activeOverlays.remove(entry);
      },
    );
  }

  // Snackbar con opción "No volver a mostrar"
  void _showDontShowAgainSnackbar(
    BuildContext context,
    String id,
  ) {
    if (_dontShowAgain.contains(id)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Este mensaje está desactivado (preferencia simulada)',
          ),
        ),
      );
      return;
    }
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.all(
                  16,
                ),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius:
                  BorderRadius.circular(
                    8,
                  ),
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Text(
                  'Consejo: puedes desactivar este mensaje',
                  style: TextStyle(
                    color:
                        Colors.black87,
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
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _dontShowAgain
                              .add(id);
                        });
                        entry.remove();
                        _activeOverlays
                            .remove(
                              entry,
                            );
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'No volverás a ver este mensaje',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'No volver a mostrar',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        entry.remove();
                        _activeOverlays
                            .remove(
                              entry,
                            );
                      },
                      child: const Text(
                        'Cerrar',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
  }

  // Snackbar con barra de progreso de tiempo restante
  void _showCountdownSnackbar(
    BuildContext context,
  ) {
    final totalSeconds = 5;
    ValueNotifier<int> remaining =
        ValueNotifier(totalSeconds);
    Timer? timer;

    final overlay = Overlay.of(context);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: ValueListenableBuilder<int>(
            valueListenable: remaining,
            builder: (context, secs, child) {
              return Container(
                padding:
                    const EdgeInsets.all(
                      16,
                    ),
                decoration: BoxDecoration(
                  color:
                      Colors.deepOrange,
                  borderRadius:
                      BorderRadius.circular(
                        8,
                      ),
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Se cerrará en:',
                            style: TextStyle(
                              color: Colors
                                  .white,
                            ),
                          ),
                        ),
                        Text(
                          '$secs s',
                          style: const TextStyle(
                            color: Colors
                                .white,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    LinearProgressIndicator(
                      value:
                          secs /
                          totalSeconds,
                      backgroundColor:
                          Colors
                              .white30,
                      valueColor:
                          const AlwaysStoppedAnimation<
                            Color
                          >(
                            Colors
                                .white,
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        if (remaining.value <= 1) {
          t.cancel();
          entry.remove();
          _activeOverlays.remove(entry);
        } else {
          remaining.value -= 1;
        }
      },
    );
  }

  // Snackbar con fondo blur (usando BackdropFilter)
  void _showBlurSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              padding:
                  const EdgeInsets.all(
                    16,
                  ),
              decoration: BoxDecoration(
                color: Colors.white
                    .withValues(
                      alpha: 0.3,
                    ),
                borderRadius:
                    BorderRadius.circular(
                      12,
                    ),
                border: Border.all(
                  color: Colors.white
                      .withValues(
                        alpha: 0.5,
                      ),
                ),
              ),
              child: const Text(
                'Fondo borroso detrás del snackbar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
    Timer(
      const Duration(seconds: 4),
      () {
        entry.remove();
        _activeOverlays.remove(entry);
      },
    );
  }

  // Snackbar con gradiente animado
  void _showGradientSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    final animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(
            seconds: 2,
          ),
        )..repeat(reverse: true);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: AnimatedBuilder(
          animation:
              animationController,
          builder: (context, child) {
            return Container(
              padding:
                  const EdgeInsets.all(
                    16,
                  ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.lerp(
                      Colors.blue,
                      Colors.purple,
                      animationController
                          .value,
                    )!,
                    Color.lerp(
                      Colors.purple,
                      Colors.pink,
                      animationController
                          .value,
                    )!,
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(
                      8,
                    ),
              ),
              child: const Text(
                'Gradiente animado',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
    Timer(
      const Duration(seconds: 6),
      () {
        animationController.dispose();
        entry.remove();
        _activeOverlays.remove(entry);
      },
    );
  }

  // Snackbar con selector de fecha
  void _showDatePickerSnackbar(
    BuildContext context,
  ) {
    DateTime selectedDate =
        DateTime.now();
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.all(
                  16,
                ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                    8,
                  ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Text(
                  'Selecciona una fecha',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceAround,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context:
                              context,
                          initialDate:
                              selectedDate,
                          firstDate:
                              DateTime(
                                2000,
                              ),
                          lastDate:
                              DateTime(
                                2100,
                              ),
                        );
                        if (date !=
                            null) {
                          selectedDate =
                              date;
                          entry
                              .markNeedsBuild(); // Actualizar la fecha mostrada
                        }
                      },
                      child: const Text(
                        'Cambiar',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        entry.remove();
                        _activeOverlays
                            .remove(
                              entry,
                            );
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Fecha seleccionada: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Aceptar',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
  }

  // Snackbar con enlace (tappable)
  void _showLinkSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Enlace abierto (simulado)',
                  ),
                ),
              );
            },
            child: Container(
              padding:
                  const EdgeInsets.all(
                    16,
                  ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.circular(
                      8,
                    ),
              ),
              child: const Row(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  Icon(
                    Icons.link,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Haz clic para abrir enlace',
                    style: TextStyle(
                      color:
                          Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
    Timer(
      const Duration(seconds: 5),
      () {
        entry.remove();
        _activeOverlays.remove(entry);
      },
    );
  }

  // Snackbar con diseño de bocadillo (chat)
  void _showChatBubbleSnackbar(
    BuildContext context,
  ) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.all(
                  12,
                ),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius:
                  const BorderRadius.only(
                    topLeft:
                        Radius.circular(
                          12,
                        ),
                    topRight:
                        Radius.circular(
                          12,
                        ),
                    bottomRight:
                        Radius.circular(
                          12,
                        ),
                  ),
            ),
            child: const Row(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage:
                      NetworkImage(
                        'https://picsum.photos/24/24?random=2',
                      ),
                ),
                SizedBox(width: 8),
                Text(
                  'Usuario: Hola!',
                  style: TextStyle(
                    color:
                        Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);
    Timer(
      const Duration(seconds: 5),
      () {
        entry.remove();
        _activeOverlays.remove(entry);
      },
    );
  }

  // Snackbar con pin (fijar)
  void _showPinnableSnackbar(
    BuildContext context,
  ) {
    ValueNotifier<bool> pinned =
        ValueNotifier(false);
    final overlay = Overlay.of(context);
    Timer? autoCloseTimer;

    void startTimer() {
      if (!pinned.value) {
        autoCloseTimer = Timer(
          const Duration(seconds: 4),
          () {
            // Solo se cierra si no está fijado
            if (!pinned.value) {
              // La entrada se eliminará aquí, pero necesitamos acceder a ella
              // La entrada se captura más adelante, por eso usamos un closure que la referencia
            }
          },
        );
      }
    }

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: ValueListenableBuilder<bool>(
            valueListenable: pinned,
            builder: (context, isPinned, child) {
              return Container(
                padding:
                    const EdgeInsets.all(
                      16,
                    ),
                decoration: BoxDecoration(
                  color: isPinned
                      ? Colors.orange
                      : Colors
                            .grey[800],
                  borderRadius:
                      BorderRadius.circular(
                        8,
                      ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isPinned
                            ? 'Fijado (no desaparece)'
                            : 'Snackbar normal',
                        style: const TextStyle(
                          color: Colors
                              .white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isPinned
                            ? Icons
                                  .push_pin
                            : Icons
                                  .push_pin_outlined,
                        color: Colors
                            .white,
                      ),
                      onPressed: () {
                        pinned.value =
                            !pinned
                                .value;
                        if (pinned
                            .value) {
                          autoCloseTimer
                              ?.cancel();
                        } else {
                          startTimer();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _activeOverlays.add(entry);

    // Configurar el timer de auto-cierre
    autoCloseTimer = Timer(
      const Duration(seconds: 4),
      () {
        if (!pinned.value &&
            entry.mounted) {
          entry.remove();
          _activeOverlays.remove(entry);
        }
      },
    );
  }

  // ========== DIÁLOGOS ==========
  void _showInfoDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Información',
        ),
        content: const Text(
          'Este es un diálogo informativo.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(ctx),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Confirmar acción',
        ),
        content: const Text(
          '¿Estás seguro de que quieres continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(ctx),
            child: const Text(
              'Cancelar',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Acción confirmada',
                  ),
                ),
              );
            },
            child: const Text(
              'Aceptar',
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                size: 60,
                color: Colors.amber,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                '¡Oferta especial!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Aprovecha un 20% de descuento en tu próxima compra.',
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(
                          ctx,
                        ),
                    child: const Text(
                      'Ahora no',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        ctx,
                      );
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '¡Cupón aplicado!',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Canjear',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSimpleDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text(
          'Elige una opción',
        ),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Opción 1 seleccionada',
                  ),
                ),
              );
            },
            child: const Text(
              'Opción 1',
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Opción 2 seleccionada',
                  ),
                ),
              );
            },
            child: const Text(
              'Opción 2',
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Opción 3 seleccionada',
                  ),
                ),
              );
            },
            child: const Text(
              'Opción 3',
            ),
          ),
        ],
      ),
    );
  }

  void _showCupertinoDialog(
    BuildContext context,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Estilo iOS'),
        content: const Text(
          'Este es un diálogo con estilo Cupertino.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text(
              'Cancelar',
            ),
            onPressed: () =>
                Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            child: const Text(
              'Aceptar',
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Aceptado en iOS',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAboutDialogWithLicenses(
    BuildContext context,
  ) {
    showAboutDialog(
      context: context,
      applicationName:
          'Mi App de Snackbars',
      applicationVersion: '1.0.0',
      applicationIcon:
          const FlutterLogo(size: 50),
      applicationLegalese:
          '© 2025 - Todos los derechos reservados',
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 16,
          ),
          child: Text(
            'Esta aplicación utiliza los siguientes paquetes con licencias:',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '• Flutter SDK - BSD License',
        ),
        const Text(
          '• Cupertino Icons - MIT License',
        ),
        const Text(
          '• Material Design Icons - Apache 2.0',
        ),
        const Text(
          '• Ejemplo de licencias adicionales',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Snackbars - Advanzed',
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
            _buildSection(
              '1. Multiple actions',
              [
                _buildCard(
                  'Dos acciones',
                  'Overlay con dos acciones',
                  () => _showMultiActionOverlay(
                    context,
                    '¿Qué quires hacer?',
                    [
                      'Aceptar',
                      'Cancelar',
                    ],
                  ),
                ),
                _buildCard(
                  'Tres acciones',
                  'Hasta tres botones',
                  () => _showMultiActionOverlay(
                    context,
                    'Elige una opción',
                    [
                      'Aceptar',
                      'Recordar',
                      'Cancelar',
                    ],
                  ),
                ),
              ],
            ),
            _buildSection(
              '2. Interactivos (desktop/web)',
              [
                _buildCard(
                  'Hover para mantener',
                  'Reinicia el contador al pasar el ratón',
                  () =>
                      _showHoverSnackbar(
                        context,
                      ),
                ),
                _buildCard(
                  'Arrastrable',
                  'Puedes moverlo por la pantalla',
                  () =>
                      _showDraggableSnackbar(
                        context,
                      ),
                ),
              ],
            ),

            _buildSection('3. Expandibles', [
              _buildCard(
                'Expandible/Colapsable',
                'Muestra más detalles al expandir',
                () =>
                    _showExpandableSnackbar(
                      context,
                    ),
              ),
            ]),

            _buildSection('4. Multimedia', [
              _buildCard(
                'Con imagen',
                'Miniatura de foto',
                () =>
                    _showImageSnackbar(
                      context,
                    ),
              ),
              _buildCard(
                'Código QR simulado',
                'Cuadrado negro simulando QR',
                () => _showQrSnackbar(
                  context,
                ),
              ),
              _buildCard(
                'Con gráfico',
                'Barra de progreso simple (ya vista)',
                () =>
                    _showCountdownSnackbar(
                      context,
                    ),
              ), // reutilizo,
            ]),

            _buildSection(
              '5. Opciones de usuario',
              [
                _buildCard(
                  'No volver a mostrar',
                  'Guarda preferencia simulada',
                  () =>
                      _showDontShowAgainSnackbar(
                        context,
                        'tip1',
                      ),
                ),
                _buildCard(
                  'Pin (fijar)',
                  'Evita que desaparezca',
                  () =>
                      _showPinnableSnackbar(
                        context,
                      ),
                ),
              ],
            ),

            _buildSection(
              '6. Tiempo y progreso',
              [
                _buildCard(
                  'Cuenta regresiva',
                  'Barra de progreso con tiempo restante',
                  () =>
                      _showCountdownSnackbar(
                        context,
                      ),
                ),
              ],
            ),

            _buildSection(
              '7. Estilos visuales',
              [
                _buildCard(
                  'Fondo blur',
                  'Efecto de desenfoque',
                  () =>
                      _showBlurSnackbar(
                        context,
                      ),
                ),
                _buildCard(
                  'Gradiente animado',
                  'Colores que cambian',
                  () =>
                      _showGradientSnackbar(
                        context,
                      ),
                ),
              ],
            ),

            _buildSection(
              '8. Formularios y entrada',
              [
                _buildCard(
                  'Selector de fecha',
                  'Permite elegir fecha',
                  () =>
                      _showDatePickerSnackbar(
                        context,
                      ),
                ),
              ],
            ),

            _buildSection(
              '9. Enlaces y navegación',
              [
                _buildCard(
                  'Enlace tappable',
                  'Abre acción al hacer clic',
                  () =>
                      _showLinkSnackbar(
                        context,
                      ),
                ),
              ],
            ),

            _buildSection(
              '10. Diseños especiales',
              [
                _buildCard(
                  'Bocadillo de chat',
                  'Estilo de burbuja',
                  () =>
                      _showChatBubbleSnackbar(
                        context,
                      ),
                ),
              ],
            ),

            _buildSection(
              '11. Simulación de hápticos/sonido',
              [
                _buildCard(
                  'Vibración (simulada)',
                  'Usa HapticFeedback (solo móvil)',
                  () {
                    HapticFeedback.heavyImpact();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '¡Vibración! (simulada)',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            _buildSection(
              '12. Cola con límite',
              [
                _buildCard(
                  'Máximo 3 overlays',
                  'Los nuevos reemplazan al más antiguo',
                  () {
                    _showMultiActionOverlay(
                      context,
                      'Mensaje ${_activeOverlays.length + 1}',
                      ['OK'],
                    );
                  },
                ),
              ],
            ),

            _buildSection(
              '13. Adaptativos por plataforma',
              [
                _buildCard(
                  'Material vs Cupertino',
                  'Usa uno u otro según plataforma',
                  () {
                    if (Theme.of(
                          context,
                        ).platform ==
                        TargetPlatform
                            .iOS) {
                      // Simular Cupertino (no hay CupertinoSnackBar nativo)
                      showCupertinoDialog(
                        context:
                            context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text(
                            'Notificación',
                          ),
                          content:
                              const Text(
                                'Estilo iOS (simulado)',
                              ),
                          actions: [
                            CupertinoDialogAction(
                              child:
                                  const Text(
                                    'OK',
                                  ),
                              onPressed: () =>
                                  Navigator.pop(
                                    context,
                                  ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Estilo Material',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),

            _buildSection('14. Diálogos', [
              _buildCard(
                'Diálogo informativo',
                'Muestra una alerta simple',
                () => _showInfoDialog(
                  context,
                ),
              ),
              _buildCard(
                'Diálogo de confirmación',
                'Pregunta al usuario',
                () =>
                    _showConfirmationDialog(
                      context,
                    ),
              ),
              _buildCard(
                'Diálogo personalizado',
                'Con icono y oferta',
                () => _showCustomDialog(
                  context,
                ),
              ),
              _buildCard(
                'SimpleDialog (opciones)',
                'Lista de opciones seleccionables',
                () => _showSimpleDialog(
                  context,
                ),
              ),
              _buildCard(
                'CupertinoAlertDialog',
                'Estilo iOS',
                () =>
                    _showCupertinoDialog(
                      context,
                    ),
              ),
              _buildCard(
                'Acerca de (Licencias)',
                'Muestra diálogo con información de licencias',
                () =>
                    _showAboutDialogWithLicenses(
                      context,
                    ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Widget> cards,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...cards,
      ],
    );
  }

  Widget _buildCard(
    String title,
    String description,
    VoidCallback onPressed,
  ) {
    return Card(
      margin:
          const EdgeInsets.symmetric(
            vertical: 4,
          ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: const Text('Show'),
        ),
      ),
    );
  }
}
