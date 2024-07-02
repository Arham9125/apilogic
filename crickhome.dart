import 'dart:convert';
import 'package:cryptocurrency/movieapp/mmodel.dart';
import 'package:http/http.dart' as http;
import 'package:cryptocurrency/cricketapp/cricketmodel.dart';
import 'package:flutter/material.dart';

class CricHome extends StatefulWidget {
  @override
  State<CricHome> createState() => _CricHomeState();
}

class _CricHomeState extends State<CricHome> {

  //created list to save the data
  final List<CricketMatch> mlist = [];


//url of api
  String url =
      "https://api.cricapi.com/v1/currentMatches?apikey=b00a8ae9-30bf-4c93-9ce7-01c78175cdd1&offset=0";

//future function as it data will be taking time to coming. async and await.
  Future<List<CricketMatch>> getinfo() async {
    var response = await http.get(Uri.parse(url));
//converting data into json
    var data = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {

        //returning model
        mlist.add(CricketMatch.fromJson(i));
      }
      return mlist;
    } else {
      throw (response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getinfo(),
          builder: (context, AsyncSnapshot<List<CricketMatch>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].name.toString()),
                      subtitle:
                          Text(snapshot.data![index].matchType.toString()),
                    );
                  });
            }
          }),
    );
  }
}
