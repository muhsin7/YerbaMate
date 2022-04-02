import 'package:flutter/material.dart';
import 'actionbuttons.dart';


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
  Widget build(BuildContext context) => Column(
    children: [
      makeCard(),
      ActionButtons(),
    ],
  );



    makeCard() => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      height: 500,
      width: 300,
      
      child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.green],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 1.0],
          )
          ),
          child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              profileInfo(),
            ],
          ),
        ),
      ),
      decoration: const BoxDecoration(
          color: const Color(0x888888),
          image: DecorationImage(
            image: AssetImage('linus.jpg'),
            fit: BoxFit.cover,
          ),
          ),
      ),
    );
    
    Widget profileInfo() => Column(
      children: [
        nameAgeRow(),
        otherInfo()
      ],
    );

    Widget nameAgeRow() => Row(
      
      children: [
        Text(
          "Test name",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
          const SizedBox(width: 10),
          Text(
          "18",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),

      ],
    );

    Widget otherInfo() => Column(
      children: [
        Row(
          children: [
            Icon(Icons.work, color: Colors.white),
            const SizedBox(width: 12),
            Text("Software Engineer (real)", style: otherInfoStyles())
          ],
        ),
        Row(
          children: [
            Icon(Icons.school, color: Colors.white),
            const SizedBox(width: 12),
            Text("Works at Google (lie)", style: otherInfoStyles())
          ],
        ),
        Row(
          children: [
            Icon(Icons.coffee, color: Colors.white),
            const SizedBox(width: 12),
            Text("Masala Chai", style: otherInfoStyles()),
            IconButton(onPressed: () {}, icon: const Icon(Icons.info), iconSize: 10, color: Colors.white,)
          ],
        )
      ],
    );

    TextStyle otherInfoStyles() => TextStyle(
      fontSize: 16,
      color: Colors.white,
    );
}
