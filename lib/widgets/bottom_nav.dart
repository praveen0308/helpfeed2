import 'package:flutter/material.dart';
import '../res/app_colors.dart';

class BottomNav extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;


  const BottomNav(
      {Key? key,
      required this.selectedTab,
      required this.tabPressed})
      : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab;

    return SizedBox(
      height: 80,
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 80,
            child: Container(
              decoration:
                  BoxDecoration(color: AppColors.greyLightest, boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1.0,
                  blurRadius: 30.0,
                )
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomTabBtn(
                    icon: Icons.history,
                    label: "History",
                    selected: _selectedTab == 0 ? true : false,
                    onPressed: () {
                      widget.tabPressed(0);
                    },
                  ),
                  BottomTabBtn(
                    icon: Icons.home_filled,
                    label: "Home",
                    selected: _selectedTab == 1 ? true : false,
                    onPressed: () {
                      widget.tabPressed(1);
                    },
                  ),
                  BottomTabBtn(
                      icon: Icons.person,
                      label: "Profile",
                      selected: _selectedTab == 2 ? true : false,
                      onPressed: () {
                        widget.tabPressed(2);
                        // Navigator.pushNamed(context, route.messagePage),
                      }),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Function() onPressed;

  const BottomTabBtn(
      {Key? key,
      required this.icon,
      required this.label,
      required this.selected,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: selected ? AppColors.primaryDarkest : AppColors.greyLightest,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: SizedBox(
              width: 24,
              height: 24,
              child: Icon(
                icon,
                color: selected ? AppColors.greyLightest : AppColors.primaryDarkest,
              ))),
    );
  }
}
