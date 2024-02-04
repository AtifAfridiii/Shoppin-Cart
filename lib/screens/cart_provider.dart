
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/screens/car_modelt.dart';
import 'package:shopping/screens/db_helper.dart';

class CartProvider with ChangeNotifier{

DBHelper db = DBHelper();

int _counter = 0;
int get Counter => _counter ;

double _totalPrice =0.0;
double get TotalPrice => _totalPrice;

late Future<List<Cart>> _cart;
 Future<List<Cart>> get cart => _cart;

 Future<List<Cart>> getData()async{

_cart=db.getCartList();
return _cart;
 }


void setPrefitems()async{
SharedPreferences Pref = await SharedPreferences.getInstance();
Pref.setInt('productItem', _counter);
Pref.setDouble('Totalproductprice', _totalPrice);
notifyListeners();
}

void getPrefitems()async{
SharedPreferences Pref = await SharedPreferences.getInstance();
_counter= Pref.getInt('productItem')??0;
_totalPrice= Pref.getDouble('Totalproductprice')??0.0;
notifyListeners();
}

void AddCounter(){
_counter++;
setPrefitems();
notifyListeners();
}

void RemoveCounter(){
  _counter--;
  setPrefitems();
  notifyListeners();
}
int getCounter(){
  getPrefitems();
  return _counter;
}

void AddTotalPrice(double value){
_totalPrice=_totalPrice+value;
setPrefitems();
notifyListeners();
}

void RemovTotalPrice(double value){
  _totalPrice=_totalPrice-value;
  setPrefitems();
  notifyListeners();
}

double getTotalPrice(){
  getPrefitems();
  return _totalPrice;
}



}