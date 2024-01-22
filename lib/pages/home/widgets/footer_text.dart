import 'package:flutter/material.dart';

class FooterText extends StatelessWidget {
  const FooterText({
    super.key,
    required this.expiration
  });
  final DateTime expiration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 25,
      color: Colors.lightGreenAccent.withOpacity(0.5),
      child: Center(
        child: Text('FCBCalculator will expire on ${expiration.month}/${expiration.day}/${expiration.year}',
        textAlign: TextAlign.center,
        style: TextStyle(color:Colors.green[900])),
      )
    );
  }
}