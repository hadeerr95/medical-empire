import 'package:flutter/material.dart';
import 'package:medical_empire_app/core/util/icons_broken.dart';

class RowTasksWidget extends StatelessWidget {
  const RowTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 150.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            padding: const EdgeInsets.all(20.0,),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Image(
                    image: AssetImage('assets/images/to-do-list.png'),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  'My Tasks',
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  '20 Task',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 150.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            padding: const EdgeInsets.all(20.0,),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Image(
                    image: AssetImage('assets/images/completed-task.png'),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  'Sent Tasks',
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  '15 Task',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
