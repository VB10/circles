// ignore_for_file: prefer_const_constructors

import 'package:align_positioned/align_positioned.dart';
import 'package:circles/sample.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

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

  @override
  void dispose() {
    super.dispose();
  }
}
