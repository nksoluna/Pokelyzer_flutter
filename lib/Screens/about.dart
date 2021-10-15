import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> devListImage = [
      "https://avatars.githubusercontent.com/u/26167071?v=4",
      "https://avatars.githubusercontent.com/u/47938031?v=4",
      "https://avatars.githubusercontent.com/u/60749514?v=4",
      "https://avatars.githubusercontent.com/u/60808968?v=4",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            color: Colors.red.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.red[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Our Team",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  buildDeveloper(name: "karnzx", imageUrl: devListImage[0]),
                  SizedBox(
                    height: 16,
                  ),
                  buildDeveloper(name: "iceman951", imageUrl: devListImage[1]),
                  SizedBox(
                    height: 16,
                  ),
                  buildDeveloper(name: "nksoluna", imageUrl: devListImage[2]),
                  SizedBox(
                    height: 16,
                  ),
                  buildDeveloper(
                      name: "zerkersaurian", imageUrl: devListImage[3]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDeveloper({required String name, required String imageUrl}) {
    return Row(
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff222222)),
            ),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
