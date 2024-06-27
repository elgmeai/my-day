import 'package:flutter/material.dart';

class Bottonn extends StatelessWidget {
  final Color $colorbotton;
  
  final void Function()? onPressedd;
  
  final Widget $chiledbotton;
  
 final BorderRadiusGeometry? $border;

  const Bottonn({super.key, required this.$colorbotton,required this.onPressedd, required this.$chiledbotton,required this.$border, });

  @override
  Widget build(BuildContext context) {
     MediaQueryData mediaquerydata=MediaQuery.of(context);
    // var height =mediaquerydata.size.height;
    var width =mediaquerydata.size.width;
    return Container(decoration: BoxDecoration(
      color: $colorbotton,
      borderRadius:  $border),
      width:width/1.2,
      child: MaterialButton(onPressed: onPressedd, child: Center(child: $chiledbotton)));
  }
}