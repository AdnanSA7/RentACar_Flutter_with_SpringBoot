import 'package:flutter/material.dart';

import 'colors.dart';
import 'custom_app_bar.dart';

class CarBookingPage extends StatefulWidget {
  const CarBookingPage({super.key});

  @override
  State<CarBookingPage> createState() => _CarBookingPageState();
}

class _CarBookingPageState extends State<CarBookingPage> {
  // Sample data for dropdowns and services
  final List<String> _services = ["Hourly", "Daily", "Outstation Round Trip"];
  List<String> carCategories = ['Sedan', 'SUV', 'Hatchback'];
  List<String> locations = ['Location 1', 'Location 2', 'Location 3'];

  String? _selectedService;
  String? selectedCategory;
  String? selectedStartLocation;
  String? selectedEndLocation;
  DateTime? startDate;
  DateTime? endDate;
  int? hoursValue;

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
              // Services Section
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
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _services.length,
                            itemBuilder: (context, index) {
                              final isSelected = _selectedService == _services[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedService = _services[index];
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.secondary : AppColors.cardBg,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      if (isSelected)
                                        BoxShadow(
                                          color: AppColors.secondary.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      _services[index],
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : AppColors.textLight,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),

              // Conditional UI based on the selected service
              if (_selectedService == "Hourly") ...[
                // Car Type Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: Text('Choose Car Type'),
                    items: carCategories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Pick-Up Location Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedStartLocation,
                    hint: Text('Pick Up Location'),
                    items: locations.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStartLocation = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Date Picker for Pick-Up Date
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: startDate != null
                          ? '${startDate!.toLocal()}'.split(' ')[0]
                          : 'Pick Up Date',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != startDate) {
                        setState(() {
                          startDate = pickedDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Pick Up Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Drop-Off Location Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15),
                        hintText: "Hours",
                        hintStyle: TextStyle(color: Colors.grey[400])
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Rent Now Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),  // Properly setting the background color
                      padding: WidgetStateProperty.all(EdgeInsets.all(25)),  // Optional: Add padding for better appearance
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(  // Optional: Make the button rounded
                        borderRadius: BorderRadius.circular(25),
                      )),
                    ),
                    onPressed: searchCars,
                    child: Text(
                      'Rent Now',
                      style: TextStyle(
                        color: Colors.white,  // Ensure the text color contrasts with the background color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              if (_selectedService == "Daily") ...[
                // Car Type Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: Text('Choose Car Type'),
                    items: carCategories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Pick-Up Location Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedStartLocation,
                    hint: Text('Pick Up Location'),
                    items: locations.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStartLocation = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 35),

                // Date Picker for Pick-Up Date
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: startDate != null
                          ? '${startDate!.toLocal()}'.split(' ')[0]
                          : 'Pick Up Date',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != startDate) {
                        setState(() {
                          startDate = pickedDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Pick Up Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 35),

                // Date Picker for Return Date
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: endDate != null
                          ? '${endDate!.toLocal()}'.split(' ')[0]
                          : 'Return Date',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != endDate) {
                        setState(() {
                          endDate = pickedDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Return Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Rent Now Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),  // Properly setting the background color
                      padding: WidgetStateProperty.all(EdgeInsets.all(25)),  // Optional: Add padding for better appearance
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(  // Optional: Make the button rounded
                        borderRadius: BorderRadius.circular(25),
                      )),
                    ),
                    onPressed: searchCars,
                    child: Text(
                      'Rent Now',
                      style: TextStyle(
                        color: Colors.white,  // Ensure the text color contrasts with the background color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              if (_selectedService == "Outstation Round Trip") ...[
                // Car Type Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: Text('Choose Car Type'),
                    items: carCategories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Pick-Up Location Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedStartLocation,
                    hint: Text('Pick Up Location'),
                    items: locations.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStartLocation = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Date Picker for Pick-Up Date
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: startDate != null
                          ? '${startDate!.toLocal()}'.split(' ')[0]
                          : 'Pick Up Date',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != startDate) {
                        setState(() {
                          startDate = pickedDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Pick Up Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Drop-Off Location Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<String>(
                    value: selectedEndLocation,
                    hint: Text('Drop Off Location'),
                    items: locations.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedEndLocation = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Date Picker for Return Date
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: endDate != null
                          ? '${endDate!.toLocal()}'.split(' ')[0]
                          : 'Return Date',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != endDate) {
                        setState(() {
                          endDate = pickedDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Return Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Rent Now Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),  // Properly setting the background color
                      padding: WidgetStateProperty.all(EdgeInsets.all(25)),  // Optional: Add padding for better appearance
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(  // Optional: Make the button rounded
                        borderRadius: BorderRadius.circular(25),
                      )),
                    ),
                    onPressed: searchCars,
                    child: Text(
                      'Rent Now',
                      style: TextStyle(
                        color: Colors.white,  // Ensure the text color contrasts with the background color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // // Rent Now Button
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.red, // Correct way to set background color in Flutter
                //       padding: EdgeInsets.symmetric(vertical: 15), // Padding for better spacing
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(25), // Rounded corners
                //       ),
                //     ),
                //     onPressed: searchCars,
                //     child: Text(
                //       'Rent Now',
                //       style: TextStyle(
                //         color: Colors.white, // Ensure the text color contrasts with the background
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void searchCars() {
    // Implement the functionality for booking here
    print('Searching for cars...');
    // Make API calls, validations, etc.
  }
}
