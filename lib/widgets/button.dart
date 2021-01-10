import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final Color backgroundColor;
  final Function onPressed;
  final Color textColor;
  final String text;
  double width;
  double height;

  Button({ this.backgroundColor, this.onPressed, this.textColor, this.text, this.width = 220.0, this.height = 60.0});

  @override
  Widget build(BuildContext context) {
      return Container(
    
        height: height,
        width: width,
       
       decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(10.0)),
         color: backgroundColor,
       ),
       child: InkWell(
         borderRadius: BorderRadius.all(Radius.circular(10.0)),
         onTap: onPressed,
         child: Center(
                    child: Text(
             text,
             style: TextStyle(
               fontSize: 20.0,
              color: textColor,
              fontWeight: FontWeight.w500,
             ),
           ),
         ),
       ),
     );
  }
}