import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/res/app_colors.dart';
import 'package:helpfeed2/ui/dashboard/pages/history/history_page.dart';
import 'package:helpfeed2/ui/dashboard/pages/history/history_page_cubit.dart';
import 'package:helpfeed2/ui/dashboard/pages/home/home_page.dart';
import 'package:helpfeed2/ui/dashboard/pages/home/home_page_cubit.dart';
import 'package:helpfeed2/ui/dashboard/pages/profile/profile_page.dart';
import 'package:helpfeed2/ui/dashboard/pages/profile/profile_page_cubit.dart';
import 'package:helpfeed2/widgets/bottom_nav.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../foodmap/foodmap_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _tabsPageController;
  int _selectedTab = 1;

  @override
  void initState() {
    super.initState();
    _tabsPageController = PageController(initialPage: 1);

  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            // const AppNavBar(
            //   txtAddress: "Marine Line, Mumbai",
            // ),
            Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabsPageController,
                  onPageChanged: (num) {
                    setState(() {
                      _selectedTab = num;
                    });
                  },
                  children: [
                    BlocProvider(
                      create: (context) => HistoryPageCubit(),
                      child: HistoryPage(),
                    ),
                    BlocProvider(
                      create: (context) =>
                          HomePageCubit(),
                      child: HomePage(),
                    ),

                    BlocProvider(
                      create: (context) =>
                          ProfilePageCubit(),
                      child: ProfilePage(),
                    ),
                  ],
                )),
            BottomNav(
              selectedTab: _selectedTab,

              tabPressed: (num) {
                _tabsPageController.animateToPage(num,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              },

            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      FoodMapPage(),
      HistoryPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_filled),
          title: ("Home"),
          activeColorPrimary: AppColors.primaryDarkest,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.white),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.map),
          title: ("FoodMap"),
          activeColorPrimary: AppColors.primaryDarkest,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.white),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.history),
          title: ("History"),
          activeColorPrimary: AppColors.primaryDarkest,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.white),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.person),
          title: ("Profile"),
          activeColorPrimary: AppColors.primaryDarkest,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.white),
    ];
  }
}
