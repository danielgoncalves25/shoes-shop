import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/shoe.dart';
import './services.dart';

class ApiService {
  ApiService();

  String shoesUrl =
      'https://the-sneaker-database.p.rapidapi.com/sneakers?limit=10';
  String gendersUrl = 'https://the-sneaker-database.p.rapidapi.com/genders';
  String brandsUrl = 'https://the-sneaker-database.p.rapidapi.com/brands';

  String releaseYear = '2020';

  Map<String, String> headers = {
    "x-rapidapi-key": sneakersKey,
    "x-rapidapi-host": "the-sneaker-database.p.rapidapi.com",
  };

  Future fetchShoes(
      {String year = '',
      String gender = '',
      String name = '',
      String brand = ''}) async {
    String query = shoesUrl;

    if (year != '') {
      query += '&releaseYear=$year';
    }
    if (brand != '') {
      query += '&brand=$brand';
    }
    if (name != '') {
      query += '&name=$name';
    }
    if (gender != '') {
      query += '&gender=$gender';
    }
    try {
      var response = await http.get(query, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['results'];
        // print(data);
        List<Shoe> shoes = [];
        data.forEach((shoe) => shoes.add(Shoe.fromMap(shoe)));
        return shoes;
      }
      print(response.statusCode);
    } catch (e) {
      print('Error fetching shoes : $e');
      return null;
    }
  }

  Future fetchBrands() async {
    try {
      var response = await http.get(brandsUrl, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['results'];
        List<String> brands = [];
        data.forEach((brand) => brands.add(brand));

        return brands;
      }
    } catch (e) {
      print('Error fetching Brand: $e');
      return null;
    }
  }

  Future fetchGenders() async {
    try {
      var response = await http.get(gendersUrl, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['results'];
        List<String> genders = [];
        data.forEach((gender) => genders.add(gender));
        return genders;
      }
    } catch (e) {
      // print('There was a problem');
      return null;
    }
  }

  void addToCart(var userData, String uid, Shoe shoe) async {
    List cartItems = userData['cart'];
    bool isShoeInCart = false;
    print(shoe.size);

    cartItems.forEach((shoeInCart) {
      if (shoeInCart['sku'] == shoe.sku && shoeInCart['size'] == shoe.size) {
        isShoeInCart = true;
        shoeInCart['quantity'] += 1;
      }
    });
    if (isShoeInCart == false) {
      cartItems.add(shoe.toJson());
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'cart': cartItems});
  }

  void deleteFromCart(var userData, String uid, int index) async {
    List cartItems = userData['cart'];
    cartItems.removeAt(index);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'cart': cartItems});
  }

  void incrementQuantity(var userData, String uid, int index) async {
    List cartItems = userData['cart'];
    cartItems[index]['quantity']++;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'cart': cartItems});
  }

  void decrementQuantity(var userData, String uid, int index) async {
    List cartItems = userData['cart'];
    var quantity = cartItems[index]['quantity']--;
    if (quantity == 1) {
      print('the quan is zero');
      cartItems.removeAt(index);
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'cart': cartItems});
  }
}
