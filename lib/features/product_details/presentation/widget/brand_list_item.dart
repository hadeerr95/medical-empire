import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrandListItem extends StatelessWidget {
  const BrandListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Asos',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ) ,
          Image.network(
              'https://1000logos.net/wp-content/uploads/2021/04/Asos-logo-500x281.png',
            width: 30.0,
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
