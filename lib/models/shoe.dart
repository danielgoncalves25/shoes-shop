class Shoe {
  String sku;
  String brand;
  String name;
  int retailPrice;
  String imgUrl;
  String colorway;
  String releaseDate;
  String story;

  Shoe({
    this.sku,
    this.brand,
    this.imgUrl,
    this.colorway,
    this.name,
    this.retailPrice,
    this.releaseDate,
    this.story,
  });

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
        brand: map['brand'],
        imgUrl: map['imgUrl'],
        name: map['name'],
        retailPrice: map['retailPrice'],
        releaseDate: map['releaseDate'],
        sku: map['sku'],
        colorway: map['colorway'],
        story: map['story']);
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
    };
  }
}
