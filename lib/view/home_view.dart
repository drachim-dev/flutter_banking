import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking/model/destination.dart';
import 'package:flutter_banking/router.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: [
        for (int i = 0; i < allDestinations.length; i++)
          allDestinations[i].keepAlive || i == _selectedIndex
              ? allDestinations[i].view
              : Container()
      ]),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: allDestinations[_selectedIndex].showFab
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Router.contactSelectionView),
              child: Icon(Icons.add))
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavigationBarItem(int index, IconData iconData) {
    final ThemeData theme = Theme.of(context);
    final Color itemColor =
        index == _selectedIndex ? theme.indicatorColor : theme.iconTheme.color;

    return Expanded(
      child: IconButton(
          onPressed: () => _onItemTapped(index),
          icon: Icon(
            iconData,
            color: itemColor,
          )),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    List<Widget> navigationBarItems = List<Widget>();
    allDestinations.forEach((destination) {
      final int index = allDestinations.indexOf(destination);

      // Placeholder widget for NotchedFloatingActionBar
      if (index == (allDestinations.length / 2).round()) {
        navigationBarItems.add(Expanded(
          child: SizedBox(),
        ));
      }
      navigationBarItems.add(_buildNavigationBarItem(index, destination.icon));
    });

    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: navigationBarItems));
  }
}