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
      body: _UiControlsView(),
    );
  }
}

class _UiControlsView
    extends StatefulWidget {
  @override
  State<_UiControlsView>
  createState() =>
      _UiControlsViewState();
}

enum Transportation {
  car,
  plane,
  boat,
  submarine,
}

class _UiControlsViewState
    extends State<_UiControlsView> {
  bool showNotifications = false;
  bool wantsBreakfast = false;
  bool wantsLunch = false;
  bool wantsDinner = false;

  Transportation?
  _selectedTransportation =
      Transportation.car;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics:
          const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
          title: Text(
            'Show Notifications',
          ),
          value: showNotifications,
          onChanged: (value) {
            setState(() {
              showNotifications =
                  !showNotifications;
            });
          },
        ),

        ExpansionTile(
          title: Text(
            'Transport vehicles',
          ),
          subtitle: Text(
            '${_selectedTransportation?.name}',
          ),
          children: [
            RadioGroup<Transportation>(
              groupValue:
                  _selectedTransportation,
              onChanged:
                  (
                    Transportation?
                    value,
                  ) {
                    setState(() {
                      _selectedTransportation =
                          value;
                    });
                  },
              child: Column(
                children: [
                  RadioListTile(
                    value:
                        Transportation
                            .car,
                    title: Text('Car'),
                    subtitle: Text(
                      'Travel by Car',
                    ),
                  ),
                  RadioListTile(
                    value:
                        Transportation
                            .plane,
                    title: Text(
                      'Plane',
                    ),
                    subtitle: Text(
                      'Travel by Plane',
                    ),
                  ),
                  RadioListTile(
                    value:
                        Transportation
                            .boat,
                    title: Text('Boat'),
                    subtitle: Text(
                      'Travel by Boat',
                    ),
                  ),
                  RadioListTile(
                    value:
                        Transportation
                            .submarine,
                    title: Text(
                      'Submarine',
                    ),
                    subtitle: Text(
                      'Travel by Submarine',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        CheckboxListTile(
          title: Text('Breakfast'),
          value: wantsBreakfast,
          onChanged: (value) {
            setState(() {
              wantsBreakfast =
                  !wantsBreakfast;
            });
          },
        ),

        CheckboxListTile(
          title: Text('Lunch'),
          value: wantsLunch,
          onChanged: (value) {
            setState(() {
              wantsLunch = !wantsLunch;
            });
          },
        ),

        CheckboxListTile(
          title: Text('Dinner'),
          value: wantsDinner,
          onChanged: (value) {
            setState(() {
              wantsDinner =
                  !wantsDinner;
            });
          },
        ),
      ],
    );
  }
}
