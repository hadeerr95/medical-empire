import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/icons_broken.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(
              IconBroken.Search,
              size: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
          ),
        );
      },
    );
  }
}