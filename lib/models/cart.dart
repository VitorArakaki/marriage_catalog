import 'package:marriage_catalog/core/store.dart';
import 'package:marriage_catalog/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  late CatalogModel catalog;

  final List<int> _itemIds = [];

  List get items => _itemIds.map((id) => catalog.getById(id)).toList();

  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    _itemIds.add(item.id);
  }
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(this.item);

  @override
  perform() {
    // TODO: implement perform
    store?.cart._itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(this.item);

  @override
  perform() {
    // TODO: implement perform
    store?.cart._itemIds.remove(item.id);
  }
}