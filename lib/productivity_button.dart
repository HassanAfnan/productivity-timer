import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final Function onPressed;

  const ProductivityButton({Key key, this.text, this.color, this.size, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        child: Text(
          this.text,
          style: TextStyle(color: Colors.white),
        ),
        onPressed:this.onPressed,
        color: this.color,
        minWidth: this.size,
    );
  }
}


