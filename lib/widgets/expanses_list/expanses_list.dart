import 'package:flutter/material.dart';
import 'package:expanse_tracker/widgets/expanses_list/expanse_item.dart';
import 'package:expanse_tracker/models/expanse.dart';

class ExpansesList extends StatelessWidget{
  const ExpansesList({
    super.key,
    required this.expanses,
    required this.onRemoveExapnse,
    });

  final List<Expanse> expanses;
  final void Function(Expanse expanse)  onRemoveExapnse;


  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: expanses.length,
      itemBuilder:(cxt,index)=>Dismissible(
        background: Container(
          color:const Color.fromARGB(55, 41, 80, 222), //Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin:  EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          )
        ,
        key: ValueKey(expanses[index]),
        onDismissed: (direction){
          onRemoveExapnse(expanses[index]);
        },
        child: ExpanseItem(expanses[index]))
        );
  }
}