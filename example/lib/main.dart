import 'package:flutter/material.dart';
import 'package:staff/staff.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 188),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Staff(
              Size(MediaQuery.of(context).size.width, 500),
            ),
          ),
        ),
        // Shimmer(
        //   baseColor: const Color(0x08ffffff), // 背景颜色
        //   highlightColor: Colors.white, // 高光的颜色
        //   loop: 2, // 闪烁循环次数，不传默认一直循环
        //   child: Image.asset('assets/images/watermelon.png',
        //       width: 325, height: 260, fit: BoxFit.contain),
        // ),
        // Container(
        //   width: 128,
        //   height: 128,
        //   margin: EdgeInsets.only(top: 20),
        //   child: CustomPaint(
        //     painter: MyPainter(),
        //   ),
        // ),
        // Container(
        //   width: 128,
        //   height: 128,
        //   margin: EdgeInsets.only(top: 20),
        //   child: ClipPath(
        //     clipper: MyPath(),
        //     child: Container(
        //       width: 128,
        //       height: 128,
        //       decoration: BoxDecoration(
        //         color: Colors.red,
        //       ),
        //       // size: Size(120, 120),
        //       // painter: MyPainter(),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 88),
        // Container(
        //   width: MediaQuery.of(context).size.width / 2,
        //   height: 200,
        //   color: Colors.pink,
        //   child: Center(
        //     child: SizedBox(
        //       width: 88,
        //       height: 88,
        //       child: LikeHandel(
        //         activeChild: Image.asset(
        //           'assets/images/rank_like_active.png',
        //           width: 40,
        //           height: 40,
        //         ),
        //         normalChild: Image.asset(
        //           'assets/images/rank_like_normal.png',
        //           width: 40,
        //           height: 40,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
