import 'dart:async';
import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:dod/pages/home/bloc/home_bloc..dart';
import 'package:dod/plugin/global/global.dart';
import 'package:dod/plugin/models/dodModel.dart';
import 'package:dod/plugin/models/responseModel.dart';
import 'package:dod/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  BlocHome bloc;

  AnimationController controller;
  Animation translate;
  Animation scale;

  void initAnimation() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    translate = Tween(begin: 500.0, end: 0.0).animate(controller);
    scale = Tween(begin: 1.0, end: 0.0).animate(controller);
    Timer(Duration(seconds: 7), () {
      controller.forward();
    });
  }

  @override
  void initState() {
    bloc = new BlocHome();
    initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
        color: azul,
        child: StreamBuilder<File>(
            stream: bloc.imagePath.stream,
            builder: (context, snapshot1) {
              if (snapshot1.hasData) {
                bloc.sendPhoto();

                return StreamBuilder<List<Dod>>(
                    stream: bloc.response.stream,
                    builder: (context, snapshot) {

                      if(snapshot.hasError){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Não foi possível detectar uma pessoa",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      color: Colors.blue.shade700,
                                      onPressed: () async {
                                        bloc.imagePath.sink.add(null);
                                        bloc.response.sink.add(null);
                                        var result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Camera()));

                                        bloc.imagePath.sink.add(result);
                                      },
                                      child: Text(
                                        "Tirar foto novamente",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                          ),
                        ],);
                      }  

                      else if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                          child: Stack(
                                children: <Widget>[
                                  Center(
                                      child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                              "${snapshot.data[index].nome}"),
                                          subtitle:
                                              Text("${snapshot.data[index].id}"),
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshot.data[index].photoUrl),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      color: Colors.blue.shade700,
                                      onPressed: () async {
                                        bloc.imagePath.sink.add(null);
                                        bloc.response.sink.add(null);
                                        var result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Camera()));

                                        bloc.imagePath.sink.add(result);
                                      },
                                      child: Text(
                                        "Tirar foto novamente",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                        );
                      } else {
                        return Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width:size.width,
                                    height: size.height,
                                    child: Image.file(snapshot1.data,fit: BoxFit.cover,),
                                  ),
                                ),
                                Center(
                                  child: StreamBuilder<double>(
                                      stream: sendProgress.stream,
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? SizedBox(
                                                width: size.width * 0.8,
                                                height: size.height * 0.2,
                                                child: Column(
                                                  children: <Widget>[
                                                    LinearProgressIndicator(
                                                      value: snapshot.data,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.amber),
                                                    ),
                                                    Container(
                                                      color: Colors.black54,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            "Estamos enviando sua foto aos nossos servidores,aguarde...",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    )
                                                  ],
                                                ))
                                            : Container();
                                      }),
                                )
                              ],
                            );
                      }
                    });
              } else {
                return Center(
                  child: SizedBox(
                    height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 40),
                                        child: Row(
                      children: <Widget>[
                        Expanded(
                                                  child: RaisedButton.icon(
                                          onPressed: () async {
                                            var result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Camera()));

                                            bloc.imagePath.sink.add(result);
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0)),
                                          color: Colors.blue.shade700,
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            "Tirar Foto",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                        ),
                      ],
                    ),
                                      ),
                  ),
                );
              }
            }));
  }
}
