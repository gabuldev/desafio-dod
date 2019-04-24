import 'package:dod/pages/home/home_page.dart';
import 'package:dod/pages/splash/splash_page.dart';
import 'package:dod/plugin/global/global.dart';
import 'package:flutter/material.dart';



class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {


  @override
  void initState() {
    statusPage.sink.add(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: statusPage.stream,
      builder: (context, snapshot) {
        return snapshot.hasData ?
        snapshot.data ? HomePage() : SplashPage()
        : Container();
      }
    );
  }
}