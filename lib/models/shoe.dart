class Shoe {
  String sku;
  String brand;
  String name;
  int retailPrice;
  String imgUrl;
  String colorway;
  String releaseDate;
  String story;
  int quantity;
  double size;

  Shoe(
      {this.sku,
      this.brand,
      this.imgUrl,
      this.colorway,
      this.name,
      this.retailPrice,
      this.releaseDate,
      this.story,
      this.quantity = 1,
      this.size});

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      brand: map['brand'],
      imgUrl: map['imgUrl'] == null ? map['image']['original'] : map['imgUrl'],
      name: map['name'],
      retailPrice: map['retailPrice'],
      releaseDate: map['releaseDate'],
      sku: map['sku'],
      colorway: map['colorway'],
      story: map['story'],
      quantity: map['quantity'] == null ? 1 : map['quantity'],
      size: map['size'] == null ? 10.0 : map['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'brand': brand,
      'imgUrl': imgUrl,
      'colorway': colorway,
      'name': name,
      'retailPrice': retailPrice,
      'releaseDate': releaseDate,
      'story': story,
      'quantity': 1,
      'size': size,
    };
  }
}
