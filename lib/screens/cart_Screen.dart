import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shopping/screens/car_modelt.dart';
import 'package:shopping/screens/cart_provider.dart';
import 'package:shopping/screens/db_helper.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({super.key});

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

DBHelper dbHelper = DBHelper();

class _Cart_ScreenState extends State<Cart_Screen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar:AppBar(title:const  Text("Products in Cart", style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),),
      centerTitle: true,
      
      backgroundColor: const Color(0xff0c7075),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7)
      ),
      actions: [
       
        Badge(
          alignment: Alignment.topRight,
           smallSize: 13.9,
          label: Consumer<CartProvider>(
            builder: (context, value, child) {
              return Text(value.getCounter().toString(),style: const TextStyle(fontWeight: FontWeight.bold),);
            },
            ),
           textColor: Colors.white,
          child: const Icon(Icons.shopping_cart,color: Colors.white,), 
        ),
        
        
        Gap(21),
        

      ],
      ),
    body: Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
               FutureBuilder(
                future: cart.getData(), 
               builder: (context, AsyncSnapshot <List<Cart>> snapshot){
                if(snapshot.hasData){

                  if(snapshot.data!.isEmpty){
  
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     Image.network('http://www.pngall.com/wp-content/uploads/5/Empty-Red-Shopping-Cart.png'),
                     const Gap(11),
                      Center(child: Text('Explore more products', style:  Theme.of(context).textTheme.subtitle2,),),
                      const Gap(191),
                    ],
                  );
                 


                  }else{
                return Expanded(child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (contex,index){
                
                return Card(
      
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Image.network(snapshot.data![index].image.toString(),height: 101,width: 101,),
                      const  Gap(11),
                           Expanded(
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Text(snapshot.data![index].ProductName.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                  InkWell(
                                    onTap: (){
                                      dbHelper.delete(snapshot.data![index].id!);
                                      cart.RemoveCounter();
                                      cart.RemovTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));
                                    },
                                    child: Icon(Icons.delete,color: Colors.red.shade700,)),
                                  ],
                                ),
                                
                                const  Gap(11),
                                 Text(snapshot.data![index].unitTag.toString()+r' $'+snapshot.data![index].productPrice.toString()),
                                   
                                   Align(
                                     alignment: Alignment.centerRight,
                                     child: InkWell(
                                      onTap: (){
                                      
                                      },
                                       child: Container(
                                         height: 41,
                                         width: 99,
                                         decoration:const  BoxDecoration(
                                           color: Color(0xff422680),
                                           borderRadius: BorderRadius.all(Radius.circular(11)),  
                                                                       ),
                                                                          child: Padding(
                                                                            padding: const  EdgeInsets.all(3),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                 InkWell(
                                                                                  onTap: (){
                                                                              int quantity = snapshot.data![index].quantity!;
                                                                               int Price = snapshot.data![index].intinialPrice!;
                                                                               quantity--;
                                                                               int newprice= quantity*Price;
      
                                                                                if(quantity>0){
                                                                                  dbHelper.updateQuantity(Cart(
                                                                                id: snapshot.data![index].id, 
                                                                                productId: snapshot.data![index].productId.toString(),
                                                                                 ProductName: snapshot.data![index].ProductName.toString(), 
                                                                                 intinialPrice: snapshot.data![index].intinialPrice,
                                                                                  productPrice: newprice,
                                                                                   quantity: quantity, 
                                                                                   unitTag: snapshot.data![index].unitTag.toString() ,
                                                                                    image: snapshot.data![index].image.toString())
                                                                                    ).then((value) {
                                                                                      quantity=0;
                                                                                      newprice=0;
                                                                                      cart.RemovTotalPrice(double.parse(snapshot.data![index].intinialPrice.toString()));            
                                                                                    }).onError((error, stackTrace) {
                                                                                      print(error.toString());
                                                                                    }) ;   
                                                                                }
                                                                                  },
                                                                                  child: Icon(Icons.remove,color: Colors.white,)),
                                                                                Text(snapshot.data![index].quantity.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                                               InkWell(
                                                                                onTap: (){
                                                                               int quantity = snapshot.data![index].quantity!;
                                                                               int Price = snapshot.data![index].intinialPrice!;
                                                                               quantity++;
                                                                               int newprice= quantity*Price;
                                                                               dbHelper.updateQuantity(Cart(
                                                                                id: snapshot.data![index].id, 
                                                                                productId: snapshot.data![index].productId.toString(),
                                                                                 ProductName: snapshot.data![index].ProductName.toString(), 
                                                                                 intinialPrice: snapshot.data![index].intinialPrice,
                                                                                  productPrice: newprice,
                                                                                   quantity: quantity, 
                                                                                   unitTag: snapshot.data![index].unitTag.toString() ,
                                                                                    image: snapshot.data![index].image.toString())
                                                                                    ).then((value) {
                                                                                      quantity=0;
                                                                                      newprice=0;
                                                                                      cart.AddTotalPrice(double.parse(snapshot.data![index].intinialPrice.toString()));            
                                                                                    }).onError((error, stackTrace) {
                                                                                      print(error.toString());
                                                                                    }) ;   
      
                                                                                },
                                                                                child: const Icon(Icons.add,color: Colors.white,)),
                                                                              ],
                                                                            ),
                                                                          ) ,
                                       ),
                                     ),
                                   )
                              ],
                             ),
                           ),
                            
                         
                         
                        ],
                      ),
                    
                    ],
                  )
                );
              }),
            );

                  }
                                 }
                 
            return const Text(' '); },)
           ,
           Consumer<CartProvider>(builder: (context,value,child){
            return Visibility(
              visible: value.getTotalPrice().toString() == "0.00" ? false : true ,
              child: Column(
                children: [
                  Reusable(title: 'Sub Total', value:r"$"+ value.getTotalPrice().toString()),
                   Reusable(title: 'Discount 5%', value:r"$"+ '11'),
                    Reusable(title: 'Total', value:r"$"+ value.getTotalPrice().toString())
                ],
              ),
            );
           })
        ],
      ),
    ),
    );
  }
}

// ignore: must_be_immutable
class Reusable extends StatelessWidget {
  String title , value;
   Reusable({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Text(title,style: Theme.of(context).textTheme.subtitle2,),
         Text(value.toString(),style: Theme.of(context).textTheme.subtitle2,),
      
        ],
      ),
    );
  }
}