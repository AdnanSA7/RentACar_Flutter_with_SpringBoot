import 'package:flutter/material.dart';
import 'package:parallax_cards/parallax_cards.dart';
import 'package:project_practice/model/cars_for_slider.dart';

class CarCards extends StatefulWidget {
  const CarCards({super.key});

  @override
  State<CarCards> createState() => _CarCardsState();
}

class _CarCardsState extends State<CarCards> {

  List<CarsForSlider> carsList = CarsForSlider.cars;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ParallaxCards(
          scrollDirection: Axis.horizontal,
          imagesList: carsList.map((car) => car.img).toList(),
          width: 150,
          height: 150,
          onTap: (index) {
            // Perform an action when a card is tapped
            debugPrint('${carsList[index].textValue} tapped!');
          },
          overlays: [
            for (var car in carsList)
              Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8)
                          ],
                          stops: const [0.5, 0.9],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 12,
                    child: Text(
                      car.textValue,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
          ],
        ),
        ParallaxCards(
          scrollDirection: Axis.horizontal,
          imagesList: carsList.map((car) => car.img).toList(),
          width: 150,
          height: 150,
          onTap: (index) {
            // Perform an action when a card is tapped
            debugPrint('${carsList[index].textValue} tapped!');
          },
          overlays: [
            for (var car in carsList)
              Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8)
                          ],
                          stops: const [0.5, 0.9],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 12,
                    child: Text(
                      car.textValue,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
          ],
        ),
        ParallaxCards(
          scrollDirection: Axis.horizontal,
          imagesList: carsList.map((car) => car.img).toList(),
          width: 150,
          height: 150,
          onTap: (index) {
            // Perform an action when a card is tapped
            debugPrint('${carsList[index].textValue} tapped!');
          },
          overlays: [
            for (var car in carsList)
              Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8)
                          ],
                          stops: const [0.5, 0.9],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 12,
                    child: Text(
                      car.textValue,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
          ],
        ),
      ],
    );
  }
}
