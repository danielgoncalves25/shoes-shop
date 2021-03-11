import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/services.dart';
import './screens.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _tabs = [
    Home(),
    Profile(),
  ];

  int _selectedTab = 0;
  bool isCart = false;
  double scrollDirection;

  void _selectTab(int index) {
    setState(() {
      _selectedTab = index;
      isCart = index == 1 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(_selectedTab == 0 ? "Home" : 'Profile',
                style: Theme.of(context).textTheme.headline1),
            _selectedTab == 1
                ? ElevatedButton(
                    child: Text('Sign Out'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      context.read<Authentication>().signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                  )
                : GestureDetector(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                    onTap: () {
                      print('Cart Icon was tapped');
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
          ],
        ),
      ),
      body: GestureDetector(
        onHorizontalDragStart: (details) => setState(() => scrollDirection = 0),
        onHorizontalDragUpdate: (details) {
          // print('updating');
          // print(details.delta.direction);
          setState(() => scrollDirection = details.delta.direction);
        },
        onHorizontalDragEnd: (details) => setState(() {
          if (_selectedTab != 1)
            _selectedTab++;
          else
            _selectedTab--;
        }),
        child: _tabs[_selectedTab],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        focusColor: Theme.of(context).primaryColor,
        onPressed: () {
          print('Cart Icon was tapped');
          Navigator.pushNamed(context, '/cart');
        },
        child: Icon(Icons.shopping_cart_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          elevation: 8,
          onTap: _selectTab,
          selectedItemColor: Colors.white,
          unselectedItemColor: Theme.of(context).primaryColor,
          currentIndex: _selectedTab,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
