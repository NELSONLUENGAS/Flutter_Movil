import 'package:flutter/material.dart';

class UiControlsScreen
    extends StatelessWidget {
  static const name = 'ui_controls';
  static const route = '/ui-controls';
  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UI Controls Screen',
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
      body: const _UiControlsView(),
    );
  }
}

enum Transportation {
  car,
  plane,
  boat,
  submarine,
}

enum CalendarView {
  day,
  week,
  month,
  year,
}

class _UiControlsView
    extends StatefulWidget {
  const _UiControlsView();

  @override
  State<_UiControlsView>
  createState() =>
      _UiControlsViewState();
}

class _UiControlsViewState
    extends State<_UiControlsView> {
  // Estados existentes
  bool showNotifications = false;
  bool wantsBreakfast = false;
  bool wantsLunch = false;
  bool wantsDinner = false;
  Transportation?
  _selectedTransportation =
      Transportation.car;

  // Nuevos estados
  double _sliderValue = 0.5;
  RangeValues _rangeValue =
      const RangeValues(0.2, 0.8);
  String? _dropdownValue = 'Opción 1';
  DateTime? _selectedDate;
  CalendarView _selectedView =
      CalendarView.week;
  String? _selectedChip = 'Rojo';
  bool _adaptiveSwitch = false;

  final List<String> _chipOptions = [
    'Rojo',
    'Verde',
    'Azul',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // SECCIÓN: NOTIFICACIONES
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              SwitchListTile(
                title: const Text(
                  'Mostrar notificaciones',
                ),
                value:
                    showNotifications,
                onChanged: (value) =>
                    setState(
                      () =>
                          showNotifications =
                              value,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // SECCIÓN: TRANSPORTE (ExpansionTile con RadioGroup)
        Card(
          child: ExpansionTile(
            title: const Text(
              'Transporte',
            ),
            subtitle: Text(
              'Seleccionado: ${_selectedTransportation?.name ?? 'Ninguno'}',
            ),
            children: [
              RadioGroup<
                Transportation
              >(
                groupValue:
                    _selectedTransportation,
                onChanged: (value) =>
                    setState(
                      () =>
                          _selectedTransportation =
                              value,
                    ),
                child: Column(
                  children: Transportation.values.map((
                    transport,
                  ) {
                    return RadioListTile<
                      Transportation
                    >(
                      value: transport,
                      title: Text(
                        transport.name
                            .toUpperCase(),
                      ),
                      subtitle: Text(
                        'Viajar en ${transport.name}',
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // SECCIÓN: COMIDAS (CheckboxListTile)
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Comidas',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              CheckboxListTile(
                title: const Text(
                  'Desayuno',
                ),
                value: wantsBreakfast,
                onChanged: (value) =>
                    setState(
                      () =>
                          wantsBreakfast =
                              value ??
                              false,
                    ),
              ),
              CheckboxListTile(
                title: const Text(
                  'Almuerzo',
                ),
                value: wantsLunch,
                onChanged: (value) =>
                    setState(
                      () => wantsLunch =
                          value ??
                          false,
                    ),
              ),
              CheckboxListTile(
                title: const Text(
                  'Cena',
                ),
                value: wantsDinner,
                onChanged: (value) =>
                    setState(
                      () =>
                          wantsDinner =
                              value ??
                              false,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // SECCIÓN: VALORES CONTINUOS (Slider y RangeSlider)
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Valores continuos',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                child: Column(
                  children: [
                    Text(
                      'Slider: ${_sliderValue.toStringAsFixed(2)}',
                    ),
                    Slider(
                      value:
                          _sliderValue,
                      onChanged: (v) =>
                          setState(
                            () =>
                                _sliderValue =
                                    v,
                          ),
                      min: 0,
                      max: 1,
                      divisions: 10,
                      label: _sliderValue
                          .toStringAsFixed(
                            2,
                          ),
                    ),
                    const Divider(),
                    Text(
                      'Rango: ${_rangeValue.start.toStringAsFixed(2)} - ${_rangeValue.end.toStringAsFixed(2)}',
                    ),
                    RangeSlider(
                      values:
                          _rangeValue,
                      onChanged: (v) =>
                          setState(
                            () =>
                                _rangeValue =
                                    v,
                          ),
                      min: 0,
                      max: 1,
                      divisions: 10,
                      labels: RangeLabels(
                        _rangeValue
                            .start
                            .toStringAsFixed(
                              2,
                            ),
                        _rangeValue.end
                            .toStringAsFixed(
                              2,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // SECCIÓN: SELECCIÓN ÚNICA MODERNA (SegmentedButton y Dropdown)
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Selección única moderna',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(
                      16,
                    ),
                child: Column(
                  children: [
                    SegmentedButton<
                      CalendarView
                    >(
                      segments: [
                        ButtonSegment(
                          value:
                              CalendarView
                                  .day,
                          label: Text(
                            'Día',
                          ),
                          icon: Icon(
                            Icons
                                .calendar_view_day,
                          ),
                        ),
                        ButtonSegment(
                          value:
                              CalendarView
                                  .week,
                          label: Text(
                            'Semana',
                          ),
                          icon: Icon(
                            Icons
                                .calendar_view_week,
                          ),
                        ),
                        ButtonSegment(
                          value:
                              CalendarView
                                  .month,
                          label: Text(
                            'Mes',
                          ),
                          icon: Icon(
                            Icons
                                .calendar_view_month,
                          ),
                        ),
                        ButtonSegment(
                          value:
                              CalendarView
                                  .year,
                          label: Text(
                            'Año',
                          ),
                          icon: Icon(
                            Icons
                                .date_range,
                          ),
                        ),
                      ],
                      selected: {
                        _selectedView,
                      },
                      onSelectionChanged:
                          (
                            Set<
                              CalendarView
                            >
                            newSelection,
                          ) {
                            setState(
                              () => _selectedView =
                                  newSelection
                                      .first,
                            );
                          },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DropdownButtonFormField<
                      String
                    >(
                      initialValue:
                          _dropdownValue,
                      items:
                          [
                                'Opción 1',
                                'Opción 2',
                                'Opción 3',
                              ]
                              .map(
                                (
                                  e,
                                ) => DropdownMenuItem(
                                  value:
                                      e,
                                  child:
                                      Text(
                                        e,
                                      ),
                                ),
                              )
                              .toList(),
                      onChanged: (v) =>
                          setState(
                            () =>
                                _dropdownValue =
                                    v,
                          ),
                      decoration:
                          const InputDecoration(
                            labelText:
                                'Elige una opción',
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // SECCIÓN: FECHA (DatePicker)
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Fecha',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? 'No hay fecha seleccionada'
                      : 'Fecha: ${_selectedDate!.toLocal()}'
                            .split(
                              ' ',
                            )[0],
                ),
                trailing: const Icon(
                  Icons.calendar_today,
                ),
                onTap: () async {
                  final date =
                      await showDatePicker(
                        context:
                            context,
                        initialDate:
                            DateTime.now(),
                        firstDate:
                            DateTime(
                              2000,
                            ),
                        lastDate:
                            DateTime(
                              2100,
                            ),
                      );
                  if (date != null) {
                    setState(
                      () =>
                          _selectedDate =
                              date,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // SECCIÓN: ETIQUETAS (ChoiceChip)
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Etiquetas seleccionables',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(
                      16,
                    ),
                child: Wrap(
                  spacing: 8,
                  children: _chipOptions.map((
                    chip,
                  ) {
                    return ChoiceChip(
                      label: Text(chip),
                      selected:
                          _selectedChip ==
                          chip,
                      onSelected: (selected) {
                        setState(
                          () => _selectedChip =
                              selected
                              ? chip
                              : null,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // SECCIÓN: ADAPTATIVO (SwitchListTile.adaptive)
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Control adaptativo',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              SwitchListTile.adaptive(
                title: const Text(
                  'Switch adaptativo (iOS/Android)',
                ),
                value: _adaptiveSwitch,
                onChanged: (v) => setState(
                  () =>
                      _adaptiveSwitch =
                          v,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
