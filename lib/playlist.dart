import 'package:adminanduser/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Playlist extends StatefulWidget {
  Playlist({this.title, this.url});
  final String title;
  final String url;
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Future<List> getData() async {
    final response = await get(widget.url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Mydrawer(),
      body: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return ListVideo(
                list: snapshot.data,
              );
          }),
    );
  }
}

class ListVideo extends StatefulWidget {
  List list;
  ListVideo({this.list});
  @override
  _ListVideoState createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoPlay(
                                  url:
                                      'https://youtube.com/embed/${widget.list[index]['contentDetails']['videoId']}',
                                )));
                  },
                  child: Container(
                    height: 210.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.list[index]['snippet']['thumbnails']['high']
                                ['url'],
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(16.0)),
                Text(widget.list[index]['snippet']['title']),
                Padding(padding: EdgeInsets.all(16.0)),
                Divider()
              ],
            ),
          );
        });
  }
}

class VideoPlay extends StatelessWidget {
  final String url;
  VideoPlay({this.url});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebviewScaffold(url: null),
    );
  }
}
