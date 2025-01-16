import 'package:flutter/material.dart';

class OrderTab extends StatelessWidget {
  final bool isSelected;
  final String text;

  const OrderTab({
    super.key,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            Icons.check,
            size: 15,
            color:
                isSelected ? const Color(0xff00D6D6) : const Color(0xffA2A2A2),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color:
                isSelected ? const Color(0xff404040) : const Color(0xFFA2A2A2),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.50,
            letterSpacing: -0.30,
          ),
        ),
      ],
    );
  }
}
