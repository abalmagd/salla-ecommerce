import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isLiked;
  final Function onPressed;

  const FavoriteButton({
    Key key,
    this.isLiked,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
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
  }
}
