import 'package:flutter/material.dart';

import '../../../widgets/quick_action_view.dart';

class DonorQuickActions extends StatelessWidget {
  const DonorQuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        QuickActionView(
            icon: Icons.search, onClick: () {
          Navigator.pushNamed(context, "/searchPage");
        }, txt: "Search"),
        QuickActionView(
            icon: Icons.add,
            onClick: () {
              Navigator.pushNamed(context, "/donate");
            },
            txt: "Donate"),
        QuickActionView(icon: Icons.map, onClick: () {
          Navigator.pushNamed(context,"/helpMap");
        }, txt: "Help Map"),
      ],
    );
  }
}
