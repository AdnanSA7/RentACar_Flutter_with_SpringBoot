import 'package:flutter/material.dart';
import 'package:project_practice/cars_slider.dart';
import 'package:project_practice/colors.dart';
import 'package:project_practice/custom_app_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  int _selectedCategory = 0;
  final _categories = ["Sedan", "SUV", "All","Sedan", "SUV", "All","Sedan", "SUV", "All"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      // appBar:
      // GradientAppBar(
      //     title: "Rent A Car",
      //     gradient: LinearGradient(
      //       colors: [AppColors.primary, AppColors.secondary],
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight
      //     ),
      //   titleTextStyle: TextStyle(
      //     color: Colors.white,
      //     fontWeight: FontWeight.bold
      //   ),
      // ),
      // AppBar(
      //   backgroundColor: Colors.transparent,
      //   bottomOpacity: 0,
      //   elevation: 0,
      //   title: Text("Rent A Car"),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2C3E50), Color(0xFFE74C3C)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello User",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Select your car",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.notifications_none_rounded,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            )
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Color(0xFF95A5A6),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search for your car",
                                hintStyle: TextStyle(color: Color(0xFF95A5A6)),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFE74C3C).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.tune,
                              color: Color(0xFFE74C3C),
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //   Categories
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              final isSelected = _selectedCategory == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.secondary : AppColors.cardBg,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      if(isSelected)
                                        BoxShadow(
                                          color: AppColors.secondary.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: Offset(0, 5)
                                        )
                                    ]
                                  ),
                                  child: Center(
                                    child: Text(_categories[index],
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : AppColors.textLight,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 200,
                alignment: Alignment.center,
                child: CarsSlider(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
