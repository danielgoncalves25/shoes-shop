import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../services/services.dart';
import 'package:sneakers_app/models/shoe.dart';

class ShoeDetails extends StatefulWidget {
  final Map userData;
  final Shoe shoe;

  ShoeDetails({this.shoe, this.userData});

  @override
  _ShoeDetailsState createState() => _ShoeDetailsState();
}

class _ShoeDetailsState extends State<ShoeDetails> {
  bool _openSize = true;
  double _selectedSize;
  bool _openDesc = true;
  bool displayErorr = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final String uid = context.watch<Authentication>().currentUser.uid;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.star_border_outlined),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        icon: Icon(Icons.shopping_bag),
        label: Text('\$${widget.shoe.retailPrice} - Add to Cart'),
        onPressed: () {
          if (_selectedSize != null) {
            widget.shoe.size = _selectedSize;
            context
                .read<ApiService>()
                .addToCart(widget.userData, uid, widget.shoe);
            Navigator.pop(context);
          } else {
            setState(() => displayErorr = true);
            Timer(const Duration(seconds: 3), () {
              setState(() => displayErorr = false);
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(widget.shoe.imgUrl,
                width: screenSize.width * 1, height: 300),
            Text('${widget.shoe.brand}',
                style: Theme.of(context).textTheme.headline4),
            Text('${widget.shoe.name}',
                style: Theme.of(context).textTheme.headline4),
            GestureDetector(
              onTap: () {
                setState(() => _openSize = !_openSize);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Select Size',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'View Size Guide',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: menSizes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedSize == menSizes[index])
                            _selectedSize = null;
                          else
                            _selectedSize = menSizes[index];
                        });
                      },
                      child: Container(
                        width: 70,
                        child: Card(
                          color: _selectedSize == menSizes[index]
                              ? Colors.black
                              : null,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              '${menSizes[index]}',
                              style: _selectedSize == menSizes[index]
                                  ? TextStyle(color: Colors.white)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            displayErorr
                ? Text(
                    'Please Select a size',
                    style: TextStyle(color: Colors.red[600]),
                  )
                : Container(),
            widget.shoe.story != ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _openDesc = !_openDesc);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Icon(_openDesc
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  )
                : Container(),
            _openDesc && widget.shoe.story != ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(widget.shoe.story))
                : Container(),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
            )
          ],
        ),
      ),
    );
  }
}
