import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


final formatter = DateFormat.yMd();

const  uuid = Uuid();

enum Category {food,travel,leisure,work,}  //ou're using an enum in Dart to define fixed categories (food, travel, leisure, work) for expenses, which helps avoid errors like typos.

const categoryIcons={
  Category.food:Icons.lunch_dining,
  Category.travel:Icons.flight_takeoff,
  Category.leisure:Icons.movie,
  Category.work:Icons.work,
  
};

class Expanse{ //constructer to accept some arugments
  Expanse({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category,
  }) : id = uuid.v4();        //uuid.v4() this generates a unique string id and assigns it to id whenever this expense class is initialized.

  final String id ;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }

}

class ExpanseBucket {
  const ExpanseBucket({
    required this.category,
    required this.expanses,
  });

  ExpanseBucket.forCategory(List<Expanse> allExpanses ,  this.category)
  :expanses= allExpanses.where((expanse)=>expanse.category == category).toList();

  final Category category;
  final List<Expanse> expanses;
  
  double get totalExpanses{
    double sum=0;
    for(final expanse in expanses){
        sum = sum + expanse.amount;
    }
    return sum;
  }


} 