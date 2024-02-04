class Cart {

late int ? id;
late String? productId;
late String? ProductName;
late int? intinialPrice;
late int? productPrice;
late int? quantity;
late String? unitTag;
late String? image;

Cart({
required this.id,
required this.productId,
required this.ProductName,
required this.intinialPrice,
required this.productPrice,
required this.quantity,
required this.unitTag,
required this.image, 
});


Cart.fromMap(Map<dynamic,dynamic> res)
: id=res['id'],
productId =res['productId'],
ProductName=res['ProductName'],
intinialPrice=res['intinialPrice'],
productPrice=res['productPrice'],
quantity=res['quantity'],
unitTag=res['unitTag'],
image=res['image'];

Map<String , dynamic>toMap(){
  return {
'id':id,
'productId':productId,
'ProductName':ProductName,
'intinialPrice':intinialPrice,
'productPrice':productPrice,
'quantity':quantity,
'unitTag':unitTag,
'image':image,
    
  };
}

}