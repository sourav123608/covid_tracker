import 'package:flutter/material.dart';

class MostAffectedPanel extends StatelessWidget {
  const MostAffectedPanel({super.key, required this.countryData});
 final List countryData;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Row(children: [
              Image.network(countryData[index]['countryInfo']['flag'],height: 25,),
              SizedBox(width: 10,),
              Text(countryData[index]['country'],style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text('Deaths:' + countryData[index]['deaths'].toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
            ],),
          ) ;
        },
      ),
    );
  }
}