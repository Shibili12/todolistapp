import 'package:flutter/material.dart';

class Profilewidget extends StatelessWidget {
  final String fullname;
  const Profilewidget({required this.fullname});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/images/avatar.jpg"),
          ),
          title: Text(
            fullname,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Kochi,kerala",
            style: TextStyle(color: Colors.grey),
          ),
          trailing: GestureDetector(
              child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ))),
        ),
      ),
    );
  }
}
