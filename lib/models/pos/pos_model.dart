class PosModel { 
  dynamic subTotal = 0;
  int tax = 0; 
  int discount = 0;
  int grandTotal = 0;
  List<Items>? items; 
  PosModel({this.subTotal = 0, this.tax = 0, this.discount = 0, this.grandTotal = 0, this.items,});
}
 
class Items {
  dynamic productId;
  String? name;
  int? price;
  String? image;
  int? qty;
  
  Items({this.productId, this.name, this.price, this.qty, this.image});
}
