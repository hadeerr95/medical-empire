import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/home_feed_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/pages/grid_categories.dart';

class SliderWidget extends StatefulWidget {
  final List<Sliders> images;

  const SliderWidget({Key? key, required this.images}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final CarouselController carouselController = CarouselController();

  int currentSliderIndicator = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              CarouselSlider(
                carouselController: carouselController,
                items: widget.images
                    .map(
                      (e) => GestureDetector(
                        onTap: () async {
                          print('slider clicked');
                          print(e.link);
                          if (e.link.contains(baseUrl) ||
                              e.link.contains('category') ||
                              e.link.contains('brand')) {
                            print(e.link.split('/').last);
                            int catId = int.parse(e.link.split('/').last);

                            if (e.link.contains('category')) {
                              navigateTo(
                                  context,
                                  GridCategories(
                                    isCategory: true,
                                    categoryName: '',
                                    id: catId,
                                  ));
                            } else if (e.link.contains('brand')) {
                              navigateTo(
                                  context,
                                  GridCategories(
                                    isCategory: false,
                                    categoryName: '',
                                    id: catId,
                                  ));
                            }
                          } else {
                            launchURL(url: e.link);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    displayTranslatedText(context: context, ar: '$slidersUrl${e.imageAr}', en: '$slidersUrl${e.imageEn}'),
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            // child: Image(
                            //   image: NetworkImage('$slidersUrl${e.imageEn}'),
                            //   fit: BoxFit.cover,
                            //   width: double.infinity,
                            // ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 210,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentSliderIndicator = index;
                    });
                  },
                ),
              ),
              // Container(
              //   color: Colors.white.withOpacity(.2,),
              //   width: double.infinity,
              //   height: 250,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
                      child: Container(
                        width: currentSliderIndicator == entry.key ? 12.0 : 6.0,
                        height:
                            currentSliderIndicator == entry.key ? 12.0 : 6.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : HexColor(mainColor))
                                  .withOpacity(
                            currentSliderIndicator == entry.key ? 1.0 : 0.3,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
