import 'package:flutter/material.dart';
import 'colors.dart';
import 'custom_app_bar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  int _selectedService = 0;
  final _services = ["Hourly", "Daily", "Outstation Round Trip"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: "Car Search",
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              //   Services
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
                          "Services",
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
                              itemCount: _services.length,
                              itemBuilder: (context, index) {
                                final isSelected = _selectedService == index;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedService = index;
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
                                      child: Text(_services[index],
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
            ],
          ),
        ),
      ),
    );
  }
}
