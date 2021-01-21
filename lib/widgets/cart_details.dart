import 'package:flutter/material.dart';

class CartDetails extends StatelessWidget {
  const CartDetails({
    Key key,
    @required this.cart,
    @required this.total,
    @required this.screenSize,
    @required this.items,
  }) : super(key: key);

  final List cart;
  final int total;
  final Size screenSize;
  final int items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        // color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.solid, color: Colors.black87),
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
                Text('$items Items',
                    style: Theme.of(context).textTheme.headline4),
                Spacer(),
                Text('\$$total', style: Theme.of(context).textTheme.headline4),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
            ),
            Container(
              width: screenSize.width * .9,
              height: screenSize.height * .06,
              child: RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    print('Trying to checkout');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
