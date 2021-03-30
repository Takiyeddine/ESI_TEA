import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * .2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
             height: MediaQuery.of(context).size.height * .1,
              image: AssetImage('images/icons/hot-cup.png'),
            ),
            Positioned(
              top:120,
              child: Text(
                'ESI_THE',
                style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
