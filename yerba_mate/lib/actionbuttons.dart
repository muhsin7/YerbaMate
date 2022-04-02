import 'package:flutter/material.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons>{  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(15),
    child: Center(
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
                makeButton(Colors.blue, Icons.favorite),
                makeButton(Colors.red, Icons.close),  
            ],)
      )
    )
  );

  makeButton(Color col, IconData icn) => RawMaterialButton(
        padding: EdgeInsets.all(15),
        onPressed: () {},
        child: Icon(icn, size: 30, color: col,),
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.white,
        hoverColor: Colors.green.withOpacity(0.7),
  );
}