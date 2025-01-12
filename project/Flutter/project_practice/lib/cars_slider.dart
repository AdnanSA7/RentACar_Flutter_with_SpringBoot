import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_practice/carDetails.dart';
import 'package:project_practice/model/cars_for_slider.dart';

class CarsSlider extends StatefulWidget {
  const CarsSlider({super.key});

  @override
  State<CarsSlider> createState() => _CarsSliderState();
}

class _CarsSliderState extends State<CarsSlider> {

  List data = CarsForSlider.cars;

  // @override
  // Widget build(BuildContext context) {
  //   return PageView.builder(
  //     physics: BouncingScrollPhysics(),
  //     itemCount: data.length,
  //     itemBuilder: (context, index) {
  //       var cars = data[index];
  //       return Stack(
  //         children: [
  //           Image.asset(cars.img, fit: BoxFit.cover, width: double.infinity,)
  //         ],
  //       );
  //     },
  //   );

    @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: false,
        aspectRatio: 16/9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        onPageChanged: (index, reason) {

        },
        scrollPhysics: BouncingScrollPhysics(),
      ),
      items: data.map((car) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CarDetails(car: car)
                ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        car.img,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            car.textValue,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:banner_carousel/banner_carousel.dart';
//
// class CarsSlider extends StatelessWidget {
//   const CarsSlider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BannerCarousel(
//       animation: true,
//       viewportFraction: 0.80,  // Show 60% of the next image
//       showIndicator: false,     // Disable indicators
//       customizedBanners: [
//         // First Image with border
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 2),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10.0),
//             child: Image.asset(
//               'assets/01.jpg', // Replace with your image path
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//
//         // Second Image with shadow
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.25),
//                 spreadRadius: 0,
//                 blurRadius: 4,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10.0),
//             child: Image.asset(
//               'assets/02.jpg', // Replace with your image path
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//
//         // Third Image with a green border and circular corners
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.green,
//               width: 3,
//             ),
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(50),
//             child: Image.asset(
//               'assets/03.jpg', // Replace with your image path
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
