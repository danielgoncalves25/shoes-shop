// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void _selectTab(int index) {
    setState(() {
      _selectedTab = index;
      isCart = index == 1 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var userData = context.watch<DocumentSnapshot>().data();
    // print(userData);
    var userData = {'cart': []};

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() => _selectedTab = 1);
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                radius: 20,
              ),
            ),
            Text(_selectedTab == 0 ? "Home" : 'Profile'),
            _selectedTab == 1
                ? RaisedButton(
                    child: Text('Sign Out'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
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
                    child: Stack(
                      children: [
                        Container(
                          height: 58,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 25,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: userData['cart'].length > 0
                              ? Container(
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                    child: Text(
                                      '${userData['cart'].length}',
                                      style: TextStyle(),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                    onTap: () {
                      print('Cart Icon was tapped');
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
          ],
        ),
      ),
      body: _tabs[_selectedTab],
      floatingActionButton: FloatingActionButton(
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
          onTap: _selectTab,
          // backgroundColor: Colors.white,
          selectedItemColor: Colors.white,
          // selectedFontSize: 40,
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
