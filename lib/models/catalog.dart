class CatalogModel {
  static List<Item> items = [];

  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  Item getByPosition(int pos) => items[pos];
}

class Item {
  final int id;
  final String name;
  final String desc;
  final num price;
  final String image;

  Item(
      {required this.id,
        required this.name,
        required this.desc,
        required this.price,
        required this.image});

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map["id"],
      name: map["name"],
      desc: map["desc"],
      price: map["price"],
      image: map["image"],
    );
  }

  toMap() => {
    "id": id,
    "name": name,
    "desc": desc,
    "price": price,
    "image": image,
  };
}