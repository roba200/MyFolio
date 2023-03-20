import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/widgets/morphism_card.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> document;
  const DetailPage({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              document['url'],
              fit: BoxFit.fitWidth,
              height: 300,
              width: double.infinity,
            ),
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            // Container(
            //   child: Image.network(
            //     document['url'],
            //     fit: BoxFit.fitWidth,
            //     height: 300,
            //     width: double.infinity,
            //   ),
            // ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          document['name'],
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await launchUrl(Uri.parse(document['facebook']),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                            )),
                        IconButton(
                            onPressed: () async {
                              await launchUrl(Uri.parse(document['linkedin']),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.linkedin,
                              color: Colors.blue[700],
                            )),
                        IconButton(
                            onPressed: () async {
                              await launchUrl(Uri.parse(document['github']),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.github,
                              color: Colors.black,
                            )),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text(
                        document['career'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MorphismCard(
                    child: Column(
                      children: [
                        Text(
                          "Bio",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: Text(
                            document['bio'],
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MorphismCard(
                    child: Column(
                      children: [
                        Text(
                          "Skills",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: Text(
                            document['skills'],
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MorphismCard(
                    child: Column(
                      children: [
                        Text(
                          "Education",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: Text(
                            document['education'],
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
