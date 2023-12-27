import 'package:flutter/material.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);
  static const tag = "LoginDialog";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Text("ahmed"),
    );
  }
}

contentBox(context) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsetsDirectional.only(top: 10),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "widget.title",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "widget.descriptions",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 22,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "widget.text",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
      Positioned(
        left: 10,
        right: 10,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 10,
          child:
              ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)), child: Image.asset("assets/model.jpeg")),
        ),
      ),
    ],
  );
}
