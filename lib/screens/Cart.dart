import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';
import '../models/shoe.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Stream<DocumentSnapshot> data;

  @override
  void initState() {
    super.initState();
    data = context.read<Authentication>().userData;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List cart = snapshot.data.data()['cart'];
                int total = 0;
                int items = 0;
                for (int i = 0; i < cart.length; i++) {
                  total += cart[i]['retailPrice'] * cart[i]['quantity'];
                  items += cart[i]['quantity'];
                }
                return Column(
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
                      child: Container(
                        height: screenSize.height * .58,
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            // Shoe.fromMap quantity amount is 1 by default.
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
                    ),
                    // Spacer(),
                    Checkout(
                        cart: cart,
                        total: total,
                        items: items,
                        screenSize: screenSize),
                  ],
                );
              }
              print('Cart has no data');
              return Container();
            }),
      ),
    );
  }
}
