import 'package:flutter/material.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/screens/buttons/buttons.dart';

class HomeScreen
    extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
        ),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView
    extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const BouncingScrollPhysics(),
      itemCount: appMenuitems.length,
      itemBuilder: (context, index) {
        final menuItem =
            appMenuitems[index];
        return _CustomListTile(
          menuItem: menuItem,
        );
      },
    );
  }
}

class _CustomListTile
    extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return ListTile(
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      leading: Icon(
        menuItem.icon,
        color: colors.primary,
      ),
      trailing: Icon(
        Icons
            .arrow_forward_ios_outlined,
        color: colors.primary,
      ),
      onTap: () => Navigator.pushNamed(
        context,
        menuItem.link,
      ),
    );
  }
}
