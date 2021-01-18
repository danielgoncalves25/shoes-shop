import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'screens.dart';
import '../services/services.dart';
import '../models/shoe.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  var shoes = [];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = TextEditingController();
  String year = '2020';
  Future defaultShoes;
  Future genders;
  Future brands;
  String selectedBrand;

  @override
  void initState() {
    super.initState();
    defaultShoes = _getShoes();
    genders = _getGenders();
    brands = _getBrands();
  }

  _getShoes() async {
    return await context
        .read<ApiService>()
        .fetchShoes(year: year, gender: 'men', brand: 'Nike');
  }

  _getGenders() async {
    return await context.read<ApiService>().fetchGenders();
  }

  _getBrands() async {
    return await context.read<ApiService>().fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    // List<Shoe> cart;
    String uid = context.watch<User>().uid;
    Map userData = context.watch<DocumentSnapshot>().data();
    if (userData == null) {
      print('data null');
    }
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Text(
                        userData != null
                            ? 'Hello ${userData['name']['firstName']}'
                            : '',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                ),
                Container(
                  height: 45,
                  child: FutureBuilder(
                    future: brands,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 13,
                          itemBuilder: (context, index) {
                            var currentBrand = snapshot.data[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Card(
                                color: selectedBrand == currentBrand
                                    ? Theme.of(context).accentColor
                                    : null,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  splashColor: Theme.of(context).primaryColor,
                                  onTap: () {
                                    setState(() => selectedBrand =
                                        selectedBrand == currentBrand
                                            ? null
                                            : currentBrand);
                                    setState(() {
                                      defaultShoes = context
                                          .read<ApiService>()
                                          .fetchShoes(
                                              year: year,
                                              gender: 'men',
                                              brand: selectedBrand ?? '');
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          currentBrand,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
                FutureBuilder(
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
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
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
                                          child: Text('\$${shoe.price}'),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                print(shoe.name);
                                                context
                                                    .read<ApiService>()
                                                    .addToCart(
                                                        userData, uid, shoe);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.greenAccent[700],
                                                radius: 10,
                                                child: Icon(
                                                  Icons.add,
                                                  size: 15,
                                                ),
                                              ),
                                            )),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            shoe.imgPath,
                                          ),
                                          FittedBox(
                                            child: Text(
                                              shoe.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ],
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
