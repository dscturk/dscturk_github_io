import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'posts_build.dart';

void main() {
  var page;
  var title;
  var osakaPost = window.document.getElementById('osaka-post');
  if (osakaPost == null) {
    title = 'DSC TURK';
    var posts = <Widget>[];
    for (var postName in PostsBuild.posts.keys) {
      var post = PostsBuild.posts[postName];
      final gradientStart = Color.fromARGB(
        255,
        (int.parse(post.year) *
                (int.parse(post.month) - int.parse(post.day)).abs() *
                int.parse(post.month)) %
            64,
        (int.parse(post.year) *
                (int.parse(post.month) + int.parse(post.day)).abs() *
                int.parse(post.month)) %
            64,
        64,
      );
      final gradientEnd = Color.fromARGB(
        128,
        (int.parse(post.year) *
                (int.parse(post.month) - int.parse(post.day)).abs() *
                int.parse(post.month)) %
            64,
        (int.parse(post.year) *
                (int.parse(post.month) + int.parse(post.day)).abs() *
                int.parse(post.month)) %
            64,
        64,
      );

      posts.add(GestureDetector(
        onTap: () {
          window.location.assign(window.location.origin +
              '/blog/${post.year}/${post.month}/${post.day}/${post.name}/');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.skewX(-0.32)..translate(-16),
              child: SizedBox(
                width: 96,
                height: 64,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            gradientStart,
                            gradientEnd,
                          ],
                        ),
                      ),
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 16,
                        height: 32,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 16,
                        height: 64,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 48,
                        height: 16,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    post.author.join(', '),
                    softWrap: true,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    page = DscTurkPage(
      gradientStart: Color(0xFF250025),
      gradientEnd: Color(0xFF005050),
      title: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontSize: 32,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 8,
              ),
            ],
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'DSC TURK',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            TextSpan(
              text: ' is a collection of ',
            ),
            TextSpan(
              text: 'Developer Student Clubs ',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            TextSpan(
              text: 'chapters by Google Developers.',
            ),
          ],
        ),
      ),
      children: posts,
    );
  } else {
    var post = PostsBuild.posts[osakaPost.innerText];
    title = '${post.title} - Blog - DSC TURK';
    page = DscTurkPage(
      gradientStart: Color.fromARGB(
        255,
        (int.parse(post.year) *
                (int.parse(post.month) - int.parse(post.day)).abs() *
                int.parse(post.month)) %
            64,
        (int.parse(post.year) *
                (int.parse(post.month) + int.parse(post.day)).abs() *
                int.parse(post.month)) %
            64,
        64,
      ),
      gradientEnd: Color.fromARGB(
        128,
        (int.parse(post.year) *
                (int.parse(post.month) - int.parse(post.day)).abs() *
                int.parse(post.month)) %
            64,
        (int.parse(post.year) *
                (int.parse(post.month) + int.parse(post.day)).abs() *
                int.parse(post.month)) %
            64,
        64,
      ),
      title: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 28,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 6,
              ),
            ],
          ),
          children: <TextSpan>[
            TextSpan(
              text: post.title,
            ),
          ],
        ),
      ),
      children: <Widget>[
        Container(
          child: MarkdownBody(
            data: post.markdown,
            selectable: true,
          ),
          padding: EdgeInsets.all(32),
        ),
      ],
    );
  }

  runApp(MaterialApp(
    title: title,
    theme: ThemeData(
      primarySwatch: Colors.grey,
    ),
    home: page,
  ));
}

class DscTurkPage extends StatelessWidget {
  const DscTurkPage._({
    Key key,
    this.children,
  }) : super(key: key);

  factory DscTurkPage(
      {Key key,
      List<Widget> children,
      Color gradientStart,
      Color gradientEnd,
      RichText title}) {
    children.insert(
        0,
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(48),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  gradientStart,
                  gradientEnd,
                ],
              ),
            ),
            child: title));

    return DscTurkPage._(key: key, children: children);
  }

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () {
            window.location.assign(window.location.origin);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/gd_dsc_lockup_color.png',
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'DSC TURK',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 24,
                    color: Color(0xFF676C72),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: children,
        ),
      ),
    );
  }
}
