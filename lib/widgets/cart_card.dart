import 'package:flutter/material.dart';
import 'package:sneakers_app/models/shoe.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.screenSize,
    @required this.shoe,
    @required this.isStockxImg,
  }) : super(key: key);

  final Size screenSize;
  final Shoe shoe;
  final bool isStockxImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * .14,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: screenSize.width * .6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FittedBox(child: Text(shoe.name)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('\$${shoe.retailPrice}'),
                        Text('|'),
                        Text('${shoe.quantity}X'),
                        Text('|'),
                        // This is suppose to be the shoe size selected
                        Text('${shoe.size}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Image.network(
              shoe.imgUrl,
              height: isStockxImg ? 60 : 95,
            )
          ],
        ),
      ),
    );
  }
}
