import 'package:flutter/cupertino.dart';
import 'package:govt_survey/LayoutComponents/Layout.dart';
import 'package:provider/provider.dart';

class createGrid extends StatelessWidget {
  // final List images;
  createGrid({Key? key}) : super(key: key);
  Layout tile = new Layout();

  @override
  Widget build(BuildContext context) {
    List images = Provider
        .of<Layout>(context, listen: false)
        .images;
    print("imageReveal=$images");
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: images.length,
        itemBuilder: (BuildContext ctx, index) {
          return tile.ImageTile(ctx, index, images);
        });
  }
}