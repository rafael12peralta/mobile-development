import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        title: Text('Quiz App', style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
         children: [
           Text('Show Questions Here', style: TextStyle(
               color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
           InkWell(
             onTap: () {},
             child: Container(
               width: double.infinity,
               height: 50,
               decoration: BoxDecoration(
                 color: Colors.green,
                 borderRadius: BorderRadius.circular(10)
               ),
               child: Center(
                 child: Text('True', style: TextStyle(
                   color: Colors.white,
                   fontSize: 18,
                   fontWeight: FontWeight.bold
                 ),),
               ),
             ),
           ),
         ],
        ),
      )
    );
  }
}