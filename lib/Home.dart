import 'package:flutter/material.dart';
import 'CompetitionList.dart';
import 'ListHackerearth.dart';
import 'ListCodeChef.dart';
import 'Card.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _kTabPages = <Widget>[
      Center(child: CompetitionList()),
      Center(child: ListCodeChef()),
      Center(child: ListHackerearth()),
    ];
    final _kTabs = <Tab>[
      Tab(text: 'Codeforces',),
      Tab(text: 'Codechef'),
      Tab(text: 'Hackerearth'),
    ];

    var nowDate = new DateTime.now();
    String date = nowDate.toString().substring(0,19);

    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Codegy"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.info_outline,
                ),
                onPressed: (){
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                      title: Text('Developer'),
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Deep Godhani",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),
            PopupMenuButton(
                itemBuilder: (BuildContext context){
                  return[
                    PopupMenuItem(child: Text("Settings")),
                  ];
                }
            ),
          ],

          //tab view display
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add
          ),
          onPressed: (){},
        ),

        body: TabBarView(
          children: _kTabPages,
        ),
      ),
    );
  }
}
