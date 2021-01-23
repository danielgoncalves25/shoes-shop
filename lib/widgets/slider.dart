import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/shoe.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    Key key,
    @required this.screenSize,
    @required this.uid,
    @required this.shoe,
    @required this.isStockxImg,
    @required this.userData,
    @required this.index,
  }) : super(key: key);

  final Size screenSize;
  final String uid;
  final Shoe shoe;
  final bool isStockxImg;
  final Map userData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      // left side swipe
      actions: [
        IconSlideAction(
          closeOnTap: false,
          color: Colors.transparent,
          iconWidget: Container(
            width: screenSize.width * .2,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(18)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ApiService>()
                          .incrementQuantity(userData, uid, index);
                    },
                    child: Icon(Icons.add, color: Colors.green[600]),
                  ),
                  Text('${shoe.quantity}X',
                      style: TextStyle(color: Colors.green[600])),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ApiService>()
                          .decrementQuantity(userData, uid, index);
                    },
                    child: Icon(Icons.remove, color: Colors.green[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      // right side swipe
      secondaryActions: [
        IconSlideAction(
          closeOnTap: true,
          color: Colors.transparent,
          iconWidget: Container(
            width: screenSize.width * .2,
            child: GestureDetector(
              onTap: () {
                context.read<ApiService>().deleteFromCart(userData, uid, index);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(18)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete, color: Colors.red[600]),
                    Text(
                      'Delete',
                      style: TextStyle(color: Colors.red[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
      child: CartCard(
          screenSize: screenSize, shoe: shoe, isStockxImg: isStockxImg),
    );
  }
}
