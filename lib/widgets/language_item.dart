import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageItem extends StatelessWidget {
  final String name;
  final int likes;
  final String asset;
  final QueryDocumentSnapshot _snapshot;

  LanguageItem(this._snapshot) :
      asset = _snapshot.get('image') as String,
      likes = _snapshot.get('likes') as int,
      name = _snapshot.get('name') as String;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: FlutterLogo(
      //   size: 45,
      // ),
      leading: SvgPicture.asset('assets/$asset', height: 40,),
      title: Text(name),
      subtitle: Text('Total likes: $likes'),
      trailing: IconButton(
        icon: const Icon(Icons.thumb_up),
        iconSize: 20,
        color: Colors.lightGreen,
        onPressed: _updateVote,
      ),
    );
  }

  void _updateVote() {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final secureSnapshot = await transaction.get(_snapshot.reference);
      final currentLikes = secureSnapshot.get('likes') as int;

      transaction.update(secureSnapshot.reference, {
        'likes': currentLikes + 1
      });
    });
  }
}
