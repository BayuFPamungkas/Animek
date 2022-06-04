import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:anime_flutter/component/item_widget.dart';
import 'package:anime_flutter/component/search_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart.dart';
import '../boxes.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: Search(type: TopType.anime));
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text('Favourites'),
      ),
      body: ValueListenableBuilder<Box<Item>>(
        valueListenable: HiveBoxes.getItems().listenable(),
        builder: (context, box, _) {
          final items = box.values.toList().cast<Item>();
          if (items.isEmpty) {
            return const Center(
              child: Text('Keranjang Kosong'),
            );
          } else {
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (BuildContext context, int index) {
                Item? res = box.getAt(index);
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    res!.delete();
                  },
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 9 / 21),
                    itemBuilder: (context, index) {
                      return ItemWidget(
                          imgUrl: res!.img,
                          textTitle: res.title,
                          malId: res.malId,
                          tapType: TopType.anime);
                    },
                    itemCount: items.length,
                  ),
                );
              },
            );
          }
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
