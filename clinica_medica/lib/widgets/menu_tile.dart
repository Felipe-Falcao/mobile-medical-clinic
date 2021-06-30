import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final Function nav;

  const MenuTile({@required this.title, @required this.nav});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 55,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.grey[350],
              offset: Offset.fromDirection(14, 3),
            )
          ]),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Icon(Icons.chevron_right_rounded, size: 25)],
        ),
        onPressed: nav,
      ),
    );
  }
}
