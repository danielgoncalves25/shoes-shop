import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/widgets.dart';
import '../services/services.dart';

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
  Stream<DocumentSnapshot> data;

  String selectedBrand;

  @override
  void initState() {
    super.initState();
    defaultShoes = _getShoes();
    genders = _getGenders();
    brands = _getBrands();
    data = context.read<Authentication>().userData;
  }

  _getShoes() async {
    return await context
        .read<ApiService>()
        .fetchShoes(year: year, gender: 'men', brand: '');
  }

  _getGenders() async {
    return await context.read<ApiService>().fetchGenders();
  }

  _getBrands() async {
    return await context.read<ApiService>().fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    String uid = context.watch<User>().uid;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: StreamBuilder<DocumentSnapshot>(
                stream: data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('HomePage has data');
                    Map userData = snapshot.data.data();
                    return Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Text(
                                'Hello ${userData['info']['firstName']}',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                        ),
                        Container(
                          height: screenSize.height * .06,
                          child: FutureBuilder(
                            future: brands,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 13,
                                    itemBuilder: (context, index) {
                                      var currentBrand = snapshot.data[index];
                                      return Container(
                                        width: screenSize.width * .25,
                                        child: Card(
                                          elevation: 0,
                                          color: selectedBrand == currentBrand
                                              ? Colors.black
                                              : null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            splashColor:
                                                Theme.of(context).primaryColor,
                                            onTap: () {
                                              setState(() => selectedBrand =
                                                  selectedBrand == currentBrand
                                                      ? null
                                                      : currentBrand);
                                              setState(
                                                () {
                                                  defaultShoes = context
                                                      .read<ApiService>()
                                                      .fetchShoes(
                                                          year: year,
                                                          gender: 'men',
                                                          brand:
                                                              selectedBrand ??
                                                                  '');
                                                },
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text(
                                                    currentBrand,
                                                    style: selectedBrand ==
                                                            currentBrand
                                                        ? TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13)
                                                        : Theme.of(context)
                                                            .textTheme
                                                            .headline6,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              print('HomePage has no  data');
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                        ShoesList(
                            defaultShoes: defaultShoes,
                            screenSize: screenSize,
                            userData: userData,
                            uid: uid),
                      ],
                    );
                  }
                  return Container();
                }),
          ),
        ),
      ),
    );
  }
}
