import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  void Function()? onPressed;
  SaveButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.save,
              color: Colors.white,
            ),
            Text("Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              width: 20,
            )
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 7),
              blurRadius: 10,
              spreadRadius: -3,
              color: Colors.grey,
            ),
          ],
          color: Colors.blue[800],
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
      ),
    );
  }
}
