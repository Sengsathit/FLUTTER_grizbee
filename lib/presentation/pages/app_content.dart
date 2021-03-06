import 'package:flutter/material.dart';
import 'package:grizbee/presentation/widgets/tabbar/bottom_tabbar.dart';
import 'package:grizbee/presentation/widgets/tabbar/bottom_tabbar_section.dart';
import 'package:grizbee/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';
import 'package:grizbee/presentation/widgets/tabbar/item.dart';

// This widget aims to draw the initial shape of the app by :
// - setting up the tab bar (bottomNavigationBar)
// - setting up the content for each section of the tab bar. We use Stack here in order to keep state
class AppContent extends StatefulWidget {
  @override
  _AppContentState createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  var _currentTab = Item.info;

  @override
  Widget build(BuildContext context) {
    // WillPopScope allows us to override Android back button effects
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != Item.info) {
            _selectTab(Item.info);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        // Create all tab bar sections in an unique stack, display only the section corresponding to clicked tab item
        // Using stack allows all our navigators preserve their state as they remain inside the widget tree
        body: Stack(
          children: <Widget>[
            BottomTabBarSection(item: Item.info, currentItem: _currentTab),
            BottomTabBarSection(item: Item.scanner, currentItem: _currentTab),
            BottomTabBarSection(item: Item.transfer, currentItem: _currentTab),
            BottomTabBarSection(item: Item.more, currentItem: _currentTab),
          ],
        ),
        bottomNavigationBar: BottomTabBar(
          currentItem: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  // Handle tab selection
  void _selectTab(Item item) {
    // If we click twice on the current tab
    if (item == _currentTab) {
      // Go to the root page of the section by popping all pages
      navigatorKeys[item]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      // Retains the selected tab
      setState(() => _currentTab = item);
    }
  }
}
