import 'package:flutter/material.dart';

import '../../../widgets/quick_action_view.dart';

class ReceiverQuickActions extends StatelessWidget {
  const ReceiverQuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        QuickActionView(
            icon: Icons.search, onClick: () {
          Navigator.pushNamed(context, "/searchPage");
        }, txt: "Search"),
        QuickActionView(icon: Icons.map, onClick: () {
          Navigator.pushNamed(context,"/foodMap");
        }, txt: "Food Map"),
        QuickActionView(
            icon: Icons.star_rounded,
            onClick: () {
              Navigator.pushNamed(context, "/reviews");
            },
            txt: "Reviews"),

      ],
    );
  }
}
