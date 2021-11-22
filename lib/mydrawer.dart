import 'package:flutter/material.dart';

import 'playlist.dart';

class Mydrawer extends StatefulWidget {
  @override
  _MydrawerState createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        
              child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16.0)),
            ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
            ),
            ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Flutter'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Playlist(
                    url: 'https://sthflutter.herokuapp.com/',
                    title: 'SthFlutter',
                  )));
                },
            ),
          ],
        ),
      ),
    );
  }
}