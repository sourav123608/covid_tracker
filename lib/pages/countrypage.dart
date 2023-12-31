import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List? countryData;
  fetchCountryData() async {
    http.Response response = await http
        .get(Uri.parse('https://corona.lmao.ninja/v2/countries?sort=cases'));
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Stats'),
      ),
      body: countryData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100]!,
                        blurRadius: 10,
                        offset: const Offset(0, 10))
                  ]),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              countryData?[index]['country'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              countryData?[index]['countryInfo']['flag'],
                              height: 50,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('CONFIRMED:' + countryData![index]['cases'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                          Text('ACTIVE:' + countryData![index]['active'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                          Text('RECOVERED:' + countryData![index]['cases'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                          Text('DEATHS:' + countryData![index]['cases'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[800]),),

                        ],),
                      ))
                    ],
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData?.length),
    );
  }
}
