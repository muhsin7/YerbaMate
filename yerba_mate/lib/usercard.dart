import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final String user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            height: 500,
            width: 300,
            decoration: BoxDecoration(
                color: const Color(0x888888),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                image: const DecorationImage(
                  image: AssetImage('default-image.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20)),
          ),
          Container(
            child: Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.black.withOpacity(0.3),
                    ]),
              ),
            )),
          )
        ],
      );
}
