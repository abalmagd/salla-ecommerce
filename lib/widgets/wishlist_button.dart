import 'package:flutter/material.dart';

Widget likeButton({
  @required bool isLiked,
  @required Function onPressed,
}) =>
    CircleAvatar(
      radius: 15,
      backgroundColor: Colors.transparent,
      child: IconButton(
        splashRadius: 15,
        iconSize: 17,
        icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
        color: isLiked ? Colors.red : Colors.black,
        onPressed: onPressed,
      ),
    );
