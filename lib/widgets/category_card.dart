import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_application/utilis.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final GestureTapCallback press;
  const CategoryCard({
    required this.svgSrc,
    required this.title,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: relativeWidth(width: 300, context: context),
        height: relativeHeigth(heigth: 500, context: context),
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          // image: DecorationImage(
          //   fit: BoxFit.cover,
          //   image: AssetImage("assets/app_background.jpg"),
          // ),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 7),
              blurRadius: 10,
              spreadRadius: -3,
              color: Colors.grey,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Container(
                        width: relativeWidth(width: 170, context: context),
                        height: relativeHeigth(heigth: 170, context: context),
                        child: Image.asset(this.svgSrc)),
                    Spacer(),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
