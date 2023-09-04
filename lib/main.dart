import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_2/model/data_model.dart';
//https://codeforgeek.com/flutter-fetch-data-from-rest-api/
void main() => runApp(const MaterialApp(
  home: ImageDisplay(),
));

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key});

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModel? dataFromAPI;
  _getData() async {
    try {
      String url = "https://dummyjson.com/products";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = DataModel.fromJson(json.decode(res.body));
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String img_url1='https://docs.flutter.dev/assets/images/dash/dash-fainting.gif';
  String img_url2='https://i.imgur.com/Gi9cwgR.gif';
  String img_url='https://docs.flutter.dev/assets/images/dash/dash-fainting.gif';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Image Generator'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if(img_url==img_url1) {
              img_url = img_url2;
            }
            else{
              img_url=img_url1;
            }
          });
        },
        backgroundColor: Colors.grey[800],
        child: Icon(Icons.add),
      ),
      body:  _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  dataFromAPI!.products[index].thumbnail,
                  width: 100,
                ),
                Text(dataFromAPI!.products[index].title.toString()),
                Text("\$${dataFromAPI!.products[index].price.toString()}"),
              ],
            ),
          );
        },
        itemCount: dataFromAPI!.products.length,
      ),

    );
  }
}