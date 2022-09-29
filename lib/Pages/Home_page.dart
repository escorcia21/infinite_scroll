import 'package:flutter/material.dart';
import 'package:gifs/Models/Model_Gifs.dart';
import 'package:gifs/Provider/Gif_Provider.dart';
import 'package:gifs/Widgets/infinite_scroll.dart';
import 'package:gifs/Widgets/listGifs.dart';

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomeApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomeApp> {
  int page = 0;
  late Future<List<ModelGifs>> _listadoGifs;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    final getprovider = GifProvider();
    _listadoGifs = getprovider.getGifs(page);
    _controller = myScrollController(getNewPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _listadoGifs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              controller: _controller,
              children: listGifs(snapshot.data as List<ModelGifs>),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  getNewPage() async {
    final getprovider = GifProvider();
    page += 10;
    await getprovider.getGifs(page).then((value) {
      setState(() {
        _listadoGifs.then((gifs) => gifs.addAll(value));
      });
    });
  }
}
