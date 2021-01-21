import 'package:flutter/material.dart';

import 'package:sneakers_app/models/shoe.dart';

class ShoeDetails extends StatelessWidget {
  final Shoe shoe;
  ShoeDetails(this.shoe);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${shoe.name}'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            elevation: 5,
            child: Image.network(
              shoe.imgUrl,
              width: screenSize.width,
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
