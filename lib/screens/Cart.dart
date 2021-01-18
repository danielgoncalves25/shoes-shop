import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneakers_app/widgets/widgets.dart';

import '../models/shoe.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<DocumentSnapshot>().data()['cart'];

    int total = 0;
    for (int i = 0; i < cart.length; i++) total += cart[i]['retailPrice'];
    print(total);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(
                    'My Cart',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(
                    'Check and Pay For Your Items',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  Shoe shoe = Shoe.fromMap(cart[index]);
                  var isStockxImg =
                      shoe.imgUrl.contains('stockx') ? true : false;
                  return Container(
                    width: screenSize.width * .9,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          dragStartBehavior: DragStartBehavior.start,
                          onHorizontalDragStart: (details) {
                            print(' The start is $details');
                          },
                          onHorizontalDragUpdate: (details) {
                            print(' The update is $details');
                          },
                          child: CartCard(
                              screenSize: screenSize,
                              shoe: shoe,
                              isStockxImg: isStockxImg),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            Container(
              decoration: ShapeDecoration(
                // color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('${cart.length} Items',
                            style: Theme.of(context).textTheme.headline4),
                        Spacer(),
                        Text('\$$total',
                            style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                    ),
                    Container(
                      width: screenSize.width * .9,
                      height: screenSize.height * .06,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          child: Text('Checkout'),
                          onPressed: () {
                            print('Trying to checkout');
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
