import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_empire_app/core/util/constants.dart';

class CategoryChild extends StatelessWidget {
  const CategoryChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey , ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Icon(Icons.coronavirus_outlined,),
            space10Vertical,
            Text('Self Check' , style: Theme.of(context).textTheme.bodyText1,),
            space10Vertical,
            const Text('20 products'),
          ],
        ),
      ),
    );
  }
}
