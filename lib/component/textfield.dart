

import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String hint;
  
 final String? Function(String?)? $val;

  const MyWidget({super.key, required this.control,required this.hint,required this.$val});
  final TextEditingController control;
  @override
  Widget build(BuildContext context) {
     MediaQueryData mediaquerydata=MediaQuery.of(context);
    // var height =mediaquerydata.size.height;
    var width =mediaquerydata.size.width;
    return    Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/20, ),
          
            child: SizedBox(//height: 60,
              child: TextFormField( 
                validator: $val,
                controller: control,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(80))),
                   label: Text(hint)
                ),
              ),
            ),
          
    );
  }
}
