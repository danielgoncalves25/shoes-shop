class Shoe {
  String sku;
  String brand;
  String name;
  int price;
  String imgPath;
  String colorway;
  String releaseDate;
  String story;

  Shoe({
    this.sku,
    this.brand,
    this.imgPath,
    this.colorway,
    this.name,
    this.price,
    this.releaseDate,
    this.story,
  });

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
        brand: map['brand'],
        imgPath: map['imgUrl'],
        name: map['name'],
        price: map['retailPrice'],
        releaseDate: map['releaseDate'],
        sku: map['sku'],
        colorway: map['colorway'],
        story: map['story']);
  }

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'brand': brand,
      'imgPath': imgPath,
      'colorway': colorway,
      'name': name,
      'price': price,
      'releaseDate': releaseDate,
      'story': story,
    };
  }
}
