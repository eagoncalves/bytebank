import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPress;

  ActionButton({
    this.title,
    this.icon,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets _getPadding() {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        return EdgeInsets.fromLTRB(18, 5, 5, 18);
      } else {
        return EdgeInsets.all(8);
      }
    }

    return Padding(
      padding: _getPadding(),
      child: Material(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => onPress(),
            child: Container(
              height: 100,
              width: 150,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                    size: 24,
                  ),
                  Text(
                    this.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
