import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'error_widget.dart';
import 'language_item.dart';

class FavoriteList extends StatelessWidget {
  static Stream<QuerySnapshot> getStream() =>
      FirebaseFirestore
          .instance
          .collection('languages')
          .orderBy('likes', descending: true)
          .snapshots();

  const FavoriteList();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getStream(),
      builder: (context, languages) {
        if (languages.hasError) {
          return const ErrorItemWidget();
        }

        if (languages.hasData) {
          final data = languages.data;

          if (data != null) {
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: data.docs.length,
              itemBuilder: (context, index) =>
                  LanguageItem(data.docs[index]),
            );
          } else {
            return const ErrorItemWidget();
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
