import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class HomeScreen
    extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home';
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.primary.withValues(
                alpha: 0.05,
              ),
              colors.surface,
            ],
          ),
        ),
        child: CustomScrollView(
          physics:
              const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 80,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Home Screen',
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment
                          .topLeft,
                      end: Alignment
                          .bottomRight,
                      colors: [
                        colors.primary,
                        colors
                            .secondary,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Lista de tarjetas
            SliverPadding(
              padding:
                  const EdgeInsets.all(
                    10,
                  ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final menuItem =
                        appMenuitems[index];
                    return _CustomCard(
                      menuItem:
                          menuItem,
                    );
                  },
                  childCount:
                      appMenuitems
                          .length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomCard
    extends StatelessWidget {
  final MenuItem menuItem;

  const _CustomCard({
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
        leading: Container(
          padding: const EdgeInsets.all(
            8,
          ),
          decoration: BoxDecoration(
            color: colors.primary
                .withValues(alpha: 0.1),
            borderRadius:
                BorderRadius.circular(
                  12,
                ),
          ),
          child: Icon(
            menuItem.icon,
            color: colors.primary,
            size: 28,
          ),
        ),
        title: Text(
          menuItem.title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge,
        ),
        subtitle: Text(
          menuItem.subTitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
                color: colors.onSurface
                    .withValues(
                      alpha: 0.7,
                    ),
              ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(
            4,
          ),
          decoration: BoxDecoration(
            color: colors.primary
                .withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons
                .arrow_forward_ios_outlined,
            color: colors.primary,
            size: 18,
          ),
        ),
        onTap: () {
          context.pushNamed(
            menuItem.name,
          );
        },
      ),
    );
  }
}
