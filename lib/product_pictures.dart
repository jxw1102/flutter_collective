import 'package:flutter/material.dart';
import 'product.dart';

class ProductPicturesWidget extends StatefulWidget {
  ProductPicturesWidget({Key key, this.pictures}) : super(key: key);

  final List<Picture> pictures;

  @override
  _ProductPicturesWidgetState createState() => new _ProductPicturesWidgetState(pictures);
}

class _ProductPicturesWidgetState extends State<ProductPicturesWidget>
    with SingleTickerProviderStateMixin {
  final List<Picture> pictures;

  _ProductPicturesWidgetState(this.pictures);

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: pictures.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final pictureLength = screenSize.width - 40;
    return new Container(
        child: Column(
          children: <Widget>[
            Container(
              width: pictureLength,
              height: pictureLength,
              child: PageView.builder(
                controller: PageController(
                  initialPage: 0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: pictures.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: pictures[index].productUrl,
                  );
                },
                onPageChanged: (int index) {
                  _tabController.animateTo(index);
                }),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: TabPageSelector(
                  controller: _tabController,
                  indicatorSize: 6,
                  selectedColor: Color.fromARGB(255, 112, 112, 112)
                ),
              ),
            )
          ],
        )
    );
  }
}
