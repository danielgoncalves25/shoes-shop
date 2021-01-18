import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/shoe.dart';

class ApiService {
  ApiService();

  String shoesUrl = 'https://api.thesneakerdatabase.dev/v2/sneakers?limit=10';
  String gendersUrl = 'https://api.thesneakerdatabase.dev/v2/genders';
  String brandsUrl = 'https://api.thesneakerdatabase.dev/v2/brands';

  String releaseYear = '2020';

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
      var response = await http.get(query);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['results'];
        // print(data);
        List<Shoe> shoes = [];
        data.forEach((shoe) => shoes.add(Shoe.fromMap(shoe)));
        return shoes;
      }
      print(response.statusCode);
    } catch (e) {
      print('error : ' + e.toString());
      return null;
    }
  }

  Future fetchBrands() async {
    try {
      var response = await http.get(brandsUrl);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['results'];
        // print(data);
        List<String> brands = [];
        data.forEach((brand) => brands.add(brand));

        return brands;
      }
    } catch (e) {
      print('There was a problem');
      return null;
    }
  }

  Future fetchGenders() async {
    try {
      var response = await http.get(gendersUrl);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['results'];
        // print(data);
        List<String> genders = [];
        data.forEach((gender) => genders.add(gender));
        return genders;
      }
    } catch (e) {
      print('There was a problem');
      return null;
    }
  }

  addToCart(var userData, String uid, Shoe shoe) async {
    List cartItems = userData['cart'];
    // print(shoe.toJson());
    cartItems.add(shoe.toJson());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'cart': cartItems});
    print('Added to cart');
  }
}
