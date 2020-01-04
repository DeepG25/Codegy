import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ListCodeChef extends StatefulWidget {
  @override
  _ListCodeChefState createState() => _ListCodeChefState();
}

class _ListCodeChefState extends State<ListCodeChef> {

  var data;

  Future<String> getData(String date) async{
    var response = await http.get(
        "https://clist.by/api/v1/contest/?username=Deep_123&api_key=dc1a808142d494c857cd6dba749858c16fd202c6"
            + "&limit=20&resource__id="+ "2" +"&start__gt="+ date + "&order_by=start",
        headers: {
          "Accept" : "application/json"
        }
    );
    this.setState(() {
      var respbody = json.decode(response.body);
      data = respbody["objects"];
    });

    return "Success!";
  }

  @override
  void initState() {
    var nowDate = new DateTime.now();
    String date = nowDate.toString().substring(0,19);
    this.getData(date);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 2.0,right: 2.0,top: 5.0,bottom: 5.0),
      itemCount: data==null ? 0 : data.length,
      itemBuilder: (BuildContext context,int index){

        var start = data==null ? "" : data[index]["start"];
        var start_time = start == "" ? "" : start.toString().substring(11,16);
        var start_date = start == "" ? "" : start.toString().substring(0,10);
        start_date = start_date.substring(8,10) + "/" + start_date.substring(5,7)+"/"+start_date.substring(0,4);

        var end = data==null ? "" : data[index]["end"];
        var end_time = end == "" ? "" : end.toString().substring(11,16);
        var end_date = end == "" ? "" : end.toString().substring(0,10);
        end_date = end_date.substring(8,10) + "/" + end_date.substring(5,7)+"/"+end_date.substring(0,4);

        Future<void> _launchURL() async {
          var url = data==null ? "" : data[index]["href"];
          if (await url_launcher.canLaunch(url)) {
            await url_launcher.launch(url);
          } else {
            throw 'Could not launch $url';
          }
          return;
        }

        return Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Codechef",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 2.5,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    data==null ? "" : data[index]["event"],
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("START TIME"),
                              Text(start_time),
                              Text(start_date)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("END TIME    "),
                              Text(end_time),
                              Text(end_date)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 1.0,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.orangeAccent,
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: _launchURL,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
