import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_app/screens/screens.dart';

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
                shoe.size = userData['info']['size'];
                bool isStockxImg =
                    shoe.imgUrl.contains('stockx') ? true : false;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    // color: Colors.grey[200],
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
                              child: Text('\$${shoe.retailPrice}',
                                  style: Theme.of(context).textTheme.headline6
                                  // TextStyle(color: Colors.black),
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
                                      color: Colors.black,
                                      size: 17,
                                    ),
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoeDetails(
                                    shoe: shoe,
                                    userData: userData,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(shoe.imgUrl,
                                    height: isStockxImg
                                        ? (screenSize.height * .22)
                                        : null),
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
