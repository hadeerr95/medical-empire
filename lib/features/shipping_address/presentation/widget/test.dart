// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_empire_app/core/util/cubit/cubit.dart';
// import 'package:medical_empire_app/core/util/cubit/state.dart';
//
// class Test extends StatelessWidget {
//    Test({Key? key}) : super(key: key);
//
//    final  _currencies = [
//      "Food",
//      "Transport",
//      "Personal",
//      "Shopping",
//      "Medical",
//      "Rent",
//      "Movie",
//      "Salary"
//    ];
//
//    @override
//    Widget build(BuildContext context) {
//      return BlocBuilder<MainCubit, MainState>(
//        builder: (context, state){
//          return FormField<String>(
//            builder: (FormFieldState<String> state) {
//              return InputDecorator(
//                decoration: InputDecoration(
//                    labelStyle: Theme.of(context).textTheme.bodyText2,
//                    errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
//                    hintText: 'Please select expense',
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
//                ),
//                isEmpty: MainCubit.get(context).GovernorateController.text == '',
//                child: DropdownButtonHideUnderline(
//                  child: DropdownButton<String>(
//                    value:  MainCubit.get(context).GovernorateController.text,
//                    isDense: true,
//                    onChanged: (String? newValue) {
//                      MainCubit.get(context).GovernorateController.text = newValue!;
//                    },
//                    items: _currencies.map((String value) {
//                      return DropdownMenuItem<String>(
//                        value: value,
//                        child: Text(value),
//                      );
//                    }).toList(),
//                  ),
//                ),
//              );
//            },
//          );
//        },
//      );
//    }
// }
//
