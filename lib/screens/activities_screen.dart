import 'package:flutter/material.dart';

class Activities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        ListTile(
          title: Text('Past In Class Activities'),
          subtitle: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3, // replace with your actual list length
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Past Item $index'),
                onTap: () {
                  // handle your item click here
                },
              );
            },
          ),
        ),
        ListTile(
          title: Text('Upcoming In Class Activities'),
          subtitle: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5, // replace with your actual list length
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Current Item $index'),
                onTap: () {
                  // handle your item click here
                },
              );
            },
          ),
        ),
      ],
    ));
  }
}
