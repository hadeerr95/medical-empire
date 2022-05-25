import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';


class SliderProductDetails extends StatefulWidget {

  final ProductModel model;
  const SliderProductDetails({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<SliderProductDetails> createState() => _SliderProductDetailsState();
}

class _SliderProductDetailsState extends State<SliderProductDetails> {
  final carouselController = CarouselController();


  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Builder(
            builder: (context) {
              if(widget.model.gallery != null){
                 return SizedBox(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      CarouselSlider(
                        carouselController: carouselController,
                        items: widget.model.gallery!
                            .map(
                              (e) => GestureDetector(
                            onTap: () {

                            },
                            child: Image(
                              image: NetworkImage(e),
                              width: double.infinity,
                            ),
                          ),
                        )
                            .toList(),
                        options: CarouselOptions(
                          height: 360,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration: const Duration(seconds: 4),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: widget.model.gallery!.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 20.0,
                                height: 4.0,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                  color:
                                  (Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor).withOpacity(
                                    activeIndex == entry.key ? 1.0 : 0.3,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              }else{
                return SizedBox(
                  height: 360,
                  child: Image(
                    image: NetworkImage(widget.model.image),
                    width: double.infinity,
                  ),
                );
              }
            }
          ),
      ],
    );
  }
}
