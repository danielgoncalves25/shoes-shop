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
    String uid = context.watch<Authentication>().currentUser.uid;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.headline1,
        ),
        // backgroundColor: Colors.transparent,
      ),
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
                            'Check and Pay For Your Items',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        height: screenSize.height * .655,
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            final Shoe shoe = Shoe.fromMap(cart[index]);
                            bool isStockxImg =
                                shoe.imgUrl.contains('stockx') ? true : false;
                            return SliderWidget(
                              screenSize: screenSize,
                              uid: uid,
                              shoe: shoe,
                              isStockxImg: isStockxImg,
                              index: index,
                              userData: snapshot.data.data(),
                            );
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                    CartDetails(
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
