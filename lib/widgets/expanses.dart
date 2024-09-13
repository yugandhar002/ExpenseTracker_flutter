import 'package:flutter/material.dart';
import 'package:expanse_tracker/models/expanse.dart';
import 'package:expanse_tracker/widgets/expanses_list/expanses_list.dart';
import 'package:expanse_tracker/widgets/new_expanse.dart';
import 'package:expanse_tracker/widgets/chart/chart.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() {
    return _ExpansesState();
  }
}

class _ExpansesState extends State<Expanses> {
  final List<Expanse> _registeredExpanses = [
    Expanse(title: 'Flutter Course', amount: 19.9, date: DateTime.now(), category: Category.work),
    Expanse(title: 'Cinema', amount: 15.69, date: DateTime.now(), category: Category.leisure),
  ];

  void _openAddExpanseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        // Passing a reference to the _addExpanse method
        return NewExpanse(
          onAddExpanse: _addExpanse,
        );
      },
    );
  }

  void _addExpanse(Expanse expanse) {
    setState(() {
      _registeredExpanses.add(expanse);
    });
  }

  void _removeExapnse(Expanse expanse){
    final expanseIndex = _registeredExpanses.indexOf(expanse);
    setState(() {
      _registeredExpanses.remove(expanse);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted'),
      action: SnackBarAction(label: 'undo', onPressed: (){
        _registeredExpanses.insert(expanseIndex, expanse);
      }),
      ));
      
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent  = const Center(child: Text('No expenses found start adding some'));
    if (_registeredExpanses.isNotEmpty){
      mainContent = 
      ExpansesList(expanses: _registeredExpanses, onRemoveExapnse: _removeExapnse,);
    }


    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 209, 85, 231),
        title: const Text('Expense Tracker'), // Changed to a more descriptive title
        actions: [
          IconButton(
            onPressed: _openAddExpanseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expanses: _registeredExpanses),
          Expanded(child:  mainContent),
        ],
      ),
    );
  }
}
