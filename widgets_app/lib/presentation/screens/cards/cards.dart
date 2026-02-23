import 'package:flutter/material.dart';

const cards = <Map<String, dynamic>>[
  {
    'elevation': 0.0,
    'label': 'Elevation 0.0',
  },
  {
    'elevation': 1.0,
    'label': 'Elevation 1.0',
  },
  {
    'elevation': 2.0,
    'label': 'Elevation 2.0',
  },
  {
    'elevation': 3.0,
    'label': 'Elevation 3.0',
  },
  {
    'elevation': 4.0,
    'label': 'Elevation 4.0',
  },
  {
    'elevation': 5.0,
    'label': 'Elevation 5.0',
  },
];

class CardsScreen
    extends StatelessWidget {
  const CardsScreen({super.key});

  static const name = 'cards';
  static const route = '/cards';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cards Screen',
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
      body: _CardsView(colors: colors),
    );
  }
}

class _CardsView
    extends StatelessWidget {
  final ColorScheme colors;

  const _CardsView({
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: 50,
      ),
      child: Column(
        children: [
          ...cards.map(
            (card) => AccentSideCard(
              label:
                  card['label']
                      as String,
              detail:
                  'Conferencia Flutter 2025',
              elevation:
                  card['elevation']
                      as double,
              accentColor:
                  colors.tertiary,
            ),
          ),
          ...cards.map(
            (card) => SplitGradientCard(
              title:
                  card['label']
                      as String,
              elevation:
                  card['elevation']
                      as double,
              description:
                  'Descubre nuestra nueva colección de primavera.',
              headerColor:
                  colors.primary,
              bodyStart: colors.primary,
              bodyEnd: colors.secondary,
            ),
          ),
          ...cards.map(
            (card) =>
                OutlinedGradientCard(
                  title:
                      card['label']
                          as String,
                  value: '\$1,234',
                  gradientColor:
                      colors.primary,
                  elevation:
                      card['elevation']
                          as double,
                ),
          ),
          ...cards.map(
            (card) =>
                _CardTypeImageGradient(
                  label:
                      card['label']
                          as String,
                  elevation:
                      card['elevation']
                          as double,
                ),
          ),
        ],
      ),
    );
  }
}

class AccentSideCard
    extends StatelessWidget {
  final String label;
  final String detail;
  final double elevation;
  final Color accentColor;

  const AccentSideCard({
    super.key,
    required this.label,
    required this.detail,
    required this.elevation,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Container(
      margin:
          const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
      child: Material(
        elevation: elevation,
        shadowColor: accentColor
            .withValues(alpha: 0.3),
        borderRadius:
            BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius:
                BorderRadius.circular(
                  16,
                ),
          ),
          child: Row(
            children: [
              // Acento lateral
              Container(
                width: 8,
                height: 80,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius:
                      const BorderRadius.horizontal(
                        left:
                            Radius.circular(
                              16,
                            ),
                      ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                        16,
                      ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: colors
                              .onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        detail,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight
                                  .bold,
                          color: colors
                              .onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(
                      8.0,
                    ),
                child: Icon(
                  Icons.chevron_right,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplitGradientCard
    extends StatelessWidget {
  final String title;
  final String description;
  final double elevation;
  final Color headerColor;
  final Color bodyStart;
  final Color bodyEnd;

  const SplitGradientCard({
    super.key,
    required this.title,
    required this.description,
    required this.elevation,
    required this.headerColor,
    required this.bodyStart,
    required this.bodyEnd,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Container(
      margin:
          const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
      child: Material(
        elevation: elevation,
        borderRadius:
            BorderRadius.circular(20),
        child: Column(
          children: [
            // Cabecera sólida
            Container(
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius:
                    const BorderRadius.vertical(
                      top:
                          Radius.circular(
                            20,
                          ),
                    ),
              ),
              padding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: colors
                        .onPrimary,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .w600,
                      color: colors
                          .onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            // Cuerpo gradiente
            Container(
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(
                      colors: [
                        bodyStart,
                        bodyEnd,
                      ],
                      begin: Alignment
                          .centerLeft,
                      end: Alignment
                          .centerRight,
                    ),
                borderRadius:
                    const BorderRadius.vertical(
                      bottom:
                          Radius.circular(
                            20,
                          ),
                    ),
              ),
              padding:
                  const EdgeInsets.all(
                    16,
                  ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: colors
                            .onPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons
                          .arrow_forward,
                      color: colors
                          .onPrimary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutlinedGradientCard
    extends StatelessWidget {
  final String title;
  final String value;
  final double elevation;
  final Color gradientColor;

  const OutlinedGradientCard({
    super.key,
    required this.title,
    required this.value,
    required this.elevation,
    required this.gradientColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Container(
      margin:
          const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
      child: Material(
        elevation: elevation,
        shadowColor: gradientColor
            .withValues(alpha: 0.2),
        borderRadius:
            BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: colors
                .surfaceContainerHighest,
            borderRadius:
                BorderRadius.circular(
                  20,
                ),
            border: Border.all(
              width: 2,
              color: Colors.transparent,
            ),
            gradient: SweepGradient(
              colors: [
                gradientColor,
                colors.secondary,
                gradientColor,
              ],
              stops: const [
                0.0,
                0.5,
                1.0,
              ],
            ),
          ),
          padding: const EdgeInsets.all(
            4,
          ), // Espacio para el borde
          child: Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius:
                  BorderRadius.circular(
                    16,
                  ),
            ),
            padding:
                const EdgeInsets.all(
                  16,
                ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors
                            .onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight:
                            FontWeight
                                .bold,
                        color: colors
                            .onSurface,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.all(
                        8,
                      ),
                  decoration: BoxDecoration(
                    color: gradientColor
                        .withValues(
                          alpha: 0.1,
                        ),
                    shape:
                        BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.trending_up,
                    color:
                        gradientColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardTypeImageGradient
    extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardTypeImageGradient({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGFuZHNjYXBlJTIwZGF5fGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary
                      .withValues(
                        alpha: 0.7,
                      ),
                  Colors.transparent,
                ],
                begin: Alignment
                    .bottomCenter,
                end:
                    Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors
                            .black54,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Descubre más',
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
