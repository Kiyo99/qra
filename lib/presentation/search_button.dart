import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchButton extends HookWidget {
  final Function() onPressed;

  const SearchButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
        height: 30,
        width: 30,
        padding: EdgeInsets.all(3),
        child: Icon(Icons.search_outlined, size: 18),
      ),
    );
  }
}