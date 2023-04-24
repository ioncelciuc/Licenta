import 'package:flutter/material.dart';

class AppBarCardDetails extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final TabController tabController;
  final void Function(int)? onTap;

  final List<Widget> tabs = const [
    Tab(text: 'Details'),
    Tab(text: 'Prices'),
  ];

  AppBarCardDetails({
    super.key,
    required this.title,
    required this.tabController,
    required this.onTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: actions,
      bottom: TabBar(
        controller: tabController,
        tabs: tabs,
        onTap: onTap,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height) * 1.75;
}
