class MenuItem {
  final String name;
  final double price;
  final String imageUrl;

  MenuItem(this.name, this.price, this.imageUrl);

  MenuItem.fromMap(Map map)
      : name = map['name'],
        price = map['price'],
        imageUrl = '';

  Map toMap() => {
        'name': name,
        'price': price,
      };
}
