import 'package:flutter/material.dart';
import 'actionbuttons.dart';
import 'usermodel.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          makeCard(),
          // ActionButtons(),
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
            )),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [const Spacer(), profileInfo(), interestsChips()],
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: const Color(0x888888),
            image: DecorationImage(
              image: user.imagepath != null
                  ? Image.asset('assets/images/${user.imagepath}')
                      as ImageProvider
                  : AssetImage('assets/images/default-image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget profileInfo() => Column(
        children: [nameAgeRow(), otherInfo()],
      );

  Widget nameAgeRow() => Row(
        children: [
          Text(
            user.name,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            user.age.toString(),
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
              Text(user.designation, style: otherInfoStyles())
            ],
          ),
          Row(
            children: [
              Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 12),
              SizedBox(
                width: 200,
                child: Text(user.bio,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: otherInfoStyles()),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 12),
              Text(user.location, style: otherInfoStyles()),
            ],
          )
        ],
      );

  Widget interestsChips() => Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        children: [
          for (var i in user.interests)
            Chip(
              label: Text(
                i,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 12),
              ),
              backgroundColor: Colors.green.withOpacity(0.4),
            )
        ],
      );

  TextStyle otherInfoStyles() => TextStyle(
        fontSize: 16,
        color: Colors.white,
      );
}
