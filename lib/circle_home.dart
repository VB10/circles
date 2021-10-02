// ignore_for_file: prefer_const_constructors

import 'package:align_positioned/align_positioned.dart';
import 'package:circles/sample.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo(this.title, {Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.4, end: 1);
  static final _sizeTween = Tween<double>(begin: 200, end: 300);

  final String title;
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        child: Card(
          elevation: 10,
          child: Text(title),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  PageItems _currentIndex = PageItems.first;

  bool _isAnimate = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: Row(
          children: [
            Spacer(),
            FloatingActionButton(
              child: Text('1'),
              onPressed: () {
                setState(() {
                  _currentIndex = PageItems.first;
                });
              },
            ),
            FloatingActionButton(
              child: Text('2'),
              onPressed: () {
                setState(() {
                  _currentIndex = PageItems.second;
                });
              },
            ),
            FloatingActionButton(
              child: Text('3'),
              onPressed: () {
                setState(() {
                  _currentIndex = PageItems.third;
                });
              },
            ),
            Spacer(),
          ],
        ),
        appBar: AppBar(),
        body: GestureDetector(
          onHorizontalDragEnd: (details) {},
          onHorizontalDragUpdate: (details) async {
            if (details.delta.dx > 0) {
              if (!_isAnimate) {
                _isAnimate = true;
                await Future.delayed(Duration(milliseconds: 300));
                if (_currentIndex == PageItems.first) {
                  _currentIndex = PageItems.third;
                } else {
                  _currentIndex = PageItems.values[_currentIndex.index - 1];
                }

                setState(() {});
                _isAnimate = false;
              }
            } else {
              if (!_isAnimate) {
                _isAnimate = true;
                await Future.delayed(Duration(milliseconds: 500));
                if (_currentIndex == PageItems.third) {
                  _currentIndex = PageItems.first;
                } else {
                  _currentIndex = PageItems.values[_currentIndex.index + 1];
                }

                setState(() {});
                _isAnimate = false;
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Stack(
              children: items(_currentIndex),
            ),
          ),
        ),
      );

  Stack _try2() {
    return Stack(
      children: <Widget>[
        AnimatedAlignPositioned(
          duration: Duration(milliseconds: 2000),
          alignment: Alignment.center,
          // rotateDegrees: 0,
          rotateDegrees: _currentIndex == 0 ? 0 : -120,
          matrix4Transform: Matrix4Transform().scale(3).upRight(30),
          moveByContainerWidth: _currentIndex == 0 ? 0.02 : 0,
          child: CircleAvatar(),
        ),
        AnimatedAlignPositioned(
          duration: Duration(milliseconds: 2000),
          alignment: Alignment.center,
          matrix4Transform: Matrix4Transform().scale(3).upRight(15).left(75),
          moveByContainerWidth: -0.04,
          child: CircleAvatar(
            backgroundColor: Colors.orange,
          ),
        ),
        AnimatedAlignPositioned(
          duration: Duration(milliseconds: 2000),
          alignment: Alignment.center,
          rotateDegrees: 0,
          matrix4Transform: Matrix4Transform().scale(3),
          child: CircleAvatar(
            backgroundColor: Colors.pink,
          ),
        ),
      ],
    );
  }

  Stack _circler() {
    return Stack(
      children: <Widget>[
        AnimatedAlignPositioned(
          duration: Duration(milliseconds: 2000),
          alignment: Alignment.center,
          rotateDegrees: 0,
          matrix4Transform: Matrix4Transform().scale(3).upRight(15),
          moveByContainerWidth: 0.02,
          child: CircleAvatar(),
        ),
        AnimatedAlignPositioned(
          duration: Duration(milliseconds: 2000),
          alignment: Alignment.center,
          matrix4Transform: Matrix4Transform().scale(3).upRight(15).left(75),
          moveByContainerWidth: -0.04,
          child: CircleAvatar(
            backgroundColor: Colors.orange,
          ),
        ),
        AnimatedAlignPositioned(
          duration: Duration(milliseconds: 2000),
          alignment: Alignment.center,
          rotateDegrees: 0,
          matrix4Transform: Matrix4Transform().scale(3),
          child: CircleAvatar(
            backgroundColor: Colors.pink,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}


  // @override
  // void initState() {
  //   super.initState();
  //   controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
  //   animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
  //     ..addStatusListener((status) {
  //       // print('x');
  //       // if (status == AnimationStatus.completed) {
  //       //   controller.reverse();
  //       // } else if (status == AnimationStatus.dismissed) {
  //       //   controller.forward();
  //       // }
  //     });
  //   controller.forward();
  // }

              // // Expanded(
              // //     child: Stack(
              // //   children: [
              // //     AnimatedAlignPositioned(
              // //       moveByChildWidth: 1,
              // //       duration: const Duration(seconds: 3),
              // //       rotateDegrees: false ? 0 : 360,
              // //       // matrix4Transform: Matrix4Transform().right(10),
              // //       child: AnimatedContainer(
              // //           width: 50, height: 50, color: true ? Colors.blue : Colors.red, duration: Duration(seconds: 2)),
              // //     ),
              // //     AnimatedAlignPositioned(
              // //       duration: Duration(seconds: 3),
              // //       rotateDegrees: false ? 0 : 180,
              // //       // matrix4Transform: Matrix4Transform().down(40),
              // //       child: AnimatedContainer(
              // //           width: 50,
              // //           height: 50,
              // //           color: true ? Colors.yellow : Colors.red,
              // //           duration: Duration(seconds: 2)),
              // //     ),
              // //     AnimatedAlignPositioned(
              // //       moveByChildWidth: 1,
              // //       duration: const Duration(seconds: 3),
              // //       rotateDegrees: false ? 0 : 360,
              // //       matrix4Transform: Matrix4Transform().left(10),
              // //       child: AnimatedContainer(
              // //           width: 50, height: 50, color: true ? Colors.green : Colors.red, duration: Duration(seconds: 2)),
              // //     ),
              // //   ],
              // // )),
              // Expanded(
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       Transform.translate(
              //           offset: Offset(100, 200),
              //           child: Container(
              //             child: AlignPositioned(
              //               alignment: Alignment.topLeft,
              //               // rotateDegrees: 30,
              //               dy: 100,
              //               dx: 50,
              //               // matrix4Transform: Matrix4,
              //               moveByChildWidth: 1,
              //               child: Icon(
              //                 Icons.info,
              //                 size: 100,
              //               ),
              //             ),
              //           ))

              //       // Positioned(left: 10, child: AnimatedLogo('0', animation: animation)),
              //       // Positioned(right: 0, child: AnimatedLogo('1', animation: animation)),
              //       // Positioned(child: AnimatedLogo('2', animation: animation)),
              //     ],
              //   ),
              // ),
              // Expanded(
              //   child: Text('data'),
              //   // child: Container(
              //   //   color: Colors.black,
              //   //   child: Transform(
              //   //     alignment: Alignment.topRight,
              //   //     transform: Matrix4.identity()..applyToVector3Array([1, 2]),
              //   //     child: Container(
              //   //       padding: const EdgeInsets.all(8.0),
              //   //       color: const Color(0xFFE8581C),
              //   //       child: const Text('Apartment for rent!'),
              //   //     ),
              //   //   ),
              //   // ),
              // )