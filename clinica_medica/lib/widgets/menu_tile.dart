import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final Function nav;

  const MenuTile({@required this.title, @required this.nav});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.teal[50],
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black26,
              offset: Offset.fromDirection(14, 3),
            )
          ]),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Icon(Icons.arrow_forward_ios_rounded, size: 18)
          ],
        ),
        onPressed: nav,
      ),
    );
  }
}
