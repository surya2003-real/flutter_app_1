import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: ImageDisplay(),
));

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key});

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {

  int ninjaLevel = 0;
  String img_url1='https://docs.flutter.dev/assets/images/dash/dash-fainting.gif';
  String img_url2='https://i.imgur.com/Gi9cwgR.gif';
  String img_url='https://docs.flutter.dev/assets/images/dash/dash-fainting.gif';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Image Generator'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
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
      body: Column(
        children: [
          Center(
            child: Image.network(img_url
            ),
          ),
          const Text("Tap on the floating button to change gif"),
        ],
      ),

    );
  }
}