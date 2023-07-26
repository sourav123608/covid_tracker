// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/pages/countrypage.dart';
import 'package:covid_tracker/panels/infopanel.dart';
import 'package:covid_tracker/panels/mostaffaectedcountry.dart';
import 'package:covid_tracker/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData = {};
  fetchWorldWideData() async {
    http.Response response =
        await http.get(Uri.parse('https://corona.lmao.ninja/v2/all'));
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

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
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('COVID-19 TRACKER'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              height: 100,
              color: Colors.orange[100],
              child: Text(
                DataSource.quote,
                style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Worldwide',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Regional',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (worldData == null)
              const CircularProgressIndicator()
            else
              WorldWidePanel(worldData: worldData),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Most affected Countries',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (countryData == null)
              Container()
            else
              MostAffectedPanel(countryData: countryData ?? []),
            const InfoPanel(),
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              'WE ARE TOGETHER IN THE FIGHT',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
