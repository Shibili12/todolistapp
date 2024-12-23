import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/images/dp2.jpg"),
          ),
          title: Text(
            '"The memories is a sheild and life helper"',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Tamim Al-Barghouti",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
