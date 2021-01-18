import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shoe.dart';
import '../services/services.dart';

class ShoesList extends StatelessWidget {
  const ShoesList({
    Key key,
    @required this.defaultShoes,
    @required this.screenSize,
    @required this.userData,
    @required this.uid,
  }) : super(key: key);

  final Future defaultShoes;
  final Size screenSize;
  final Map userData;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: defaultShoes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Text('Sorry, there is no more in stock',
                style: TextStyle(color: Colors.redAccent));
          } else {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: screenSize.width * .5,
                childAspectRatio: .8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                Shoe shoe = snapshot.data[index];
                // if (shoe.imgPath.contains('stockx')) {
                //   print(shoe.imgPath);
                // }
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '\$${shoe.retailPrice}',
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ApiService>()
                                        .addToCart(userData, uid, shoe);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.greenAccent[700],
                                    radius: 10,
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(shoe.price);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  shoe.imgUrl,
                                ),
                                FittedBox(
                                  child: Text(
                                    shoe.name,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }
        return Container();
      },
    );
  }
}
