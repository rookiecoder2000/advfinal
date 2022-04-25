import 'package:flutter/material.dart';

class poppinsFont extends StatelessWidget {
  final double _size;
  final String _text;
  final Color _color;
  final FontWeight _fontWeight;

  poppinsFont(this._size, this._text, this._color, this._fontWeight);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: _size,
          color: _color,
          fontWeight: _fontWeight),
    );
  }
}
