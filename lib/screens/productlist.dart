import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shopping/screens/car_modelt.dart';
import 'package:shopping/screens/cart_Screen.dart';
import 'package:shopping/screens/cart_provider.dart';
import 'package:shopping/screens/db_helper.dart';


class Product_list extends StatefulWidget {
   Product_list({super.key});

  @override
  State<Product_list> createState() => _Product_listState();
}

DBHelper dbHelper = DBHelper();

var Productname= ['Mango','Orange','Apple','Banana','Grapes','Peaches','Cherry'];
var Unit=['Kg','Dozen','Kg','Dozen','Kg','Kg','Kg'];
var  Price=[10,20,30,40,50,60,70];
var Pic=['https://images.pexels.com/photos/2294471/pexels-photo-2294471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
         'https://images.pexels.com/photos/2090902/pexels-photo-2090902.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
         'https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
         'https://images.pexels.com/photos/61127/pexels-photo-61127.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
         'https://images.pexels.com/photos/708777/pexels-photo-708777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
         'https://images.pexels.com/photos/10026608/pexels-photo-10026608.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
         'https://images.pexels.com/photos/1149021/pexels-photo-1149021.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
];

class _Product_listState extends State<Product_list> {
  @override
  Widget build(BuildContext context) {

      final cart = Provider.of<CartProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title:const  Text("Product list", style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),),
      centerTitle: true,
      backgroundColor: const Color(0xff0c7075),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7)
      ),
      actions: [
       
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_Screen()));
          },
          child: Badge(
            alignment: Alignment.topRight,
             smallSize: 13.9,
            label: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(value.getCounter().toString(),style: const TextStyle(fontWeight: FontWeight.bold),);
              },
              ),
             textColor: Colors.white,
            child: Icon(Icons.shopping_cart,color: Colors.white,), 
          ),
        ),
        
        
        Gap(21),
        

      ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Productname.length,
              itemBuilder: (contex,index){
              
              return Card(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Image.network(Pic[index].toString(),height: 101,width: 101,),
                    const  Gap(11),
                         Expanded(
                           child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Productname[index].toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                              const  Gap(11),
                               Text(Unit[index].toString()+r' $'+Price[index].toString()),
                                 
                                 Align(
                                   alignment: Alignment.centerRight,
                                   child: InkWell(
                                    onTap: (){
                                      dbHelper.insert(
                                        Cart(
                                        id: index, 
                                        productId: index.toString(), 
                                        ProductName: Productname[index].toString(),
                                         intinialPrice:  Price[index],
                                          productPrice:  Price[index], 
                                          quantity: 1, 
                                          unitTag:  Unit[index].toString(), 
                                          image:  Pic[index].toString())
                                          
                                          ).then((value) {
                                          cart.AddTotalPrice(double.parse(Price[index].toString()));
                                          cart.AddCounter();
                                          print('Product added ');
                                          }).onError((error, stackTrace) {
                                            print(error.toString());
                                          });
                                    },
                                     child: Container(
                                       height: 41,
                                       width: 99,
                                       decoration:const  BoxDecoration(
                                         color: Color(0xff422680),
                                         borderRadius: BorderRadius.all(Radius.circular(11)),  
                                                                     ),
                                                                        child: const Center(child: Text('Add to cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
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
          )
        ],
      ),
    );
  }
}