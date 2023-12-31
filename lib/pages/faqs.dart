import 'package:covid_tracker/datasource.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FAQ'),
        ),
        body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: ((context, index) {
            return ExpansionTile(
              title: Text(DataSource.questionAnswers[index]['question'],style: TextStyle(fontWeight: FontWeight.bold),),
              children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(DataSource.questionAnswers[index]['answer']),
              )],
            );
          }),
        ));
  }
}
