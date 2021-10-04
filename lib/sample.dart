// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

CircleAvatar _normalAvatar(String title) {
  return CircleAvatar(
    radius: 50,
    backgroundImage: image,
    child: Text(
      '$title',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    ),
  );
}

CircleAvatar _bigAvatar(String title) {
  return CircleAvatar(
    radius: 60,
    backgroundImage: image,
    child: Text(
      '$title',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
    ),
  );
}

enum PageItems { first, second, third }

final image = AssetImage('sampe.png');

List<Widget> items(PageItems item) {
  switch (item) {
    case PageItems.first:
      return items1;
    case PageItems.second:
      return items2;
    case PageItems.third:
      return items3;
  }
}

final _duration = Duration(milliseconds: 300);

List<Widget> get items1 {
  return [
    AnimatedAlign(
      key: ValueKey(PageItems.first),
      duration: _duration,
      alignment: Alignment.centerLeft,
      child: _normalAvatar('1'),
    ),
    AnimatedAlign(
      key: ValueKey(PageItems.second),
      duration: _duration,
      alignment: Alignment.centerRight,
      child: _normalAvatar('2'),
    ),
    AnimatedAlign(
      key: ValueKey(PageItems.third),
      duration: _duration,
      alignment: Alignment.center,
      child: _bigAvatar('3'),
    ),
  ];
}

List<Widget> get items2 {
  return [
    AnimatedAlign(
      key: ValueKey(PageItems.second),
      duration: _duration,
      alignment: Alignment.centerLeft,
      child: _normalAvatar('2'),
    ),
    AnimatedAlign(
      key: ValueKey(PageItems.third),
      duration: _duration,
      alignment: Alignment.centerRight,
      child: _normalAvatar('3'),
    ),
    AnimatedAlign(
      key: ValueKey(PageItems.first),
      duration: _duration,
      alignment: Alignment.center,
      child: _bigAvatar('1'),
    ),
  ];
}

List<Widget> get items3 {
  return [
    AnimatedAlign(
      key: ValueKey(PageItems.third),
      duration: _duration,
      alignment: Alignment.centerLeft,
      child: _normalAvatar('3'),
    ),
    AnimatedAlign(
      key: ValueKey(PageItems.first),
      duration: _duration,
      alignment: Alignment.centerRight,
      child: _normalAvatar('1'),
    ),
    AnimatedAlign(
      key: ValueKey(PageItems.second),
      duration: _duration,
      alignment: Alignment.center,
      child: _bigAvatar('2'),
    ),
  ];
}
