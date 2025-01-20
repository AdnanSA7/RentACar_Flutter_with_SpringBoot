import 'package:flutter/material.dart';
import 'Service/api_service.dart';
import 'car_list_page.dart';
import 'Service/CarBookingService.dart';
import 'colors.dart';
import 'custom_app_bar.dart';
import 'model/Car.dart';
import 'model/rental_types.dart';

class CarBookingPage extends StatefulWidget {
  const CarBookingPage({super.key});

  @override
  State<CarBookingPage> createState() => _CarBookingPageState();
}

class _CarBookingPageState extends State<CarBookingPage> {

  final CarBookingService _carBookingService = CarBookingService();

  late Future<List<RentalTypes>> _services;
  List<String> carCategories = [];

  // Sample data for dropdowns and services
  // final List<String> _services = ["Hourly", "Daily", "Outstation Round Trip"];
  // List<String> carCategories = ['Sedan', 'SUV', 'Hatchback'];
  List<String> locations = ['Dhaka', 'Chittagong', 'Sylhet'];

  String? _selectedService;
  String? selectedCategory;
  String? selectedStartLocation;
  String? selectedEndLocation;
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController hoursValue = TextEditingController();

  List<dynamic> availableCars = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _services = ApiService().fetchRentalTypes();
  }

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

                        FutureBuilder<List<RentalTypes>>(
                            future: _services,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Text('No rental types available.');
                              }

                              // List of rental types available
                              List<RentalTypes> rentalTypes = snapshot.data!;

                              return SizedBox(
                                height: 45,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: rentalTypes.length,
                                  itemBuilder: (context, index) {
                                    final isSelected = _selectedService == rentalTypes[index].rentalTypeName;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedService = rentalTypes[index].rentalTypeName;
                                          carCategories = rentalTypes[index].carCategoryNames;
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
                                            rentalTypes[index].rentalTypeName,
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
                              );
                            }
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
                    controller: hoursValue,
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
              if (_selectedService == "OutStation Round Trip") ...[
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
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> searchCars() async {
    print(hoursValue.text);
    if (_selectedService == null || selectedCategory == null || startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
      availableCars = [];  // Clear previous results
    });

    try {
      // Fetch the cars from the service
      final carsJson = await _carBookingService.fetchAvailableCars(
        _selectedService!,
        selectedCategory!,
        startDate!,
      );

      // Map the dynamic list to List<Car>
      List<Car> cars = carsJson.map((carJson) => Car.fromJson(carJson)).toList();
      int hours = int.parse(hoursValue.text);
      List bookingExtra = [
        hours,
        selectedStartLocation,
        selectedEndLocation,
        startDate,
        endDate,
      ];


      // Navigate to CarListPage and pass the List<Car>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarListPage(
            availableCars: cars,
            extra: bookingExtra
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

// ..................=====================================================

// import 'package:flutter/material.dart';
// import 'car_list_page.dart';
// import 'Service/CarBookingService.dart';
// import 'model/Car.dart';
//
// class CarBookingPage extends StatefulWidget {
//   const CarBookingPage({super.key});
//
//   @override
//   State<CarBookingPage> createState() => _CarBookingPageState();
// }
//
// class _CarBookingPageState extends State<CarBookingPage> {
//   final CarBookingService _carBookingService = CarBookingService(); // Create an instance of the service
//
//   final List<String> _services = ["Hourly", "Daily", "Outstation Round Trip"];
//   List<String> carCategories = ['Sedan', 'SUV', 'Hatchback'];
//   List<String> locations = ['Location 1', 'Location 2', 'Location 3'];
//
//   String? _selectedService;
//   String? selectedCategory;
//   String? selectedStartLocation;
//   String? selectedEndLocation;
//   DateTime? startDate;
//   DateTime? endDate;
//
//   List<dynamic> availableCars = [];
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Car Booking'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(labelText: 'Service Type'),
//                 items: _services.map((service) {
//                   return DropdownMenuItem<String>(
//                     value: service,
//                     child: Text(service),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedService = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(labelText: 'Car Category'),
//                 items: carCategories.map((category) {
//                   return DropdownMenuItem<String>(
//                     value: category,
//                     child: Text(category),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCategory = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: 'Start Date',
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.calendar_today),
//                     onPressed: () async {
//                       final pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           startDate = pickedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 controller: TextEditingController(
//                   text: startDate != null
//                       ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
//                       : '',
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _searchCars,
//                 child: const Text('Search Cars'),
//               ),
//               const SizedBox(height: 16),
//               if (isLoading)
//                 const Center(child: CircularProgressIndicator())
//               else if (availableCars.isNotEmpty)
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: availableCars.length,
//                   itemBuilder: (context, index) {
//                     final car = availableCars[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       child: ListTile(
//                         title: Text(car['name'] ?? 'Car Name'),
//                         subtitle: Text('Price: \$${car['price'] ?? 'N/A'}'),
//                       ),
//                     );
//                   },
//                 )
//               else
//                 const Text('No cars available for the selected criteria.'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _searchCars() async {
//     if (_selectedService == null || selectedCategory == null || startDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all required fields.")),
//       );
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//       availableCars = [];
//     });
//
//     try {
//       final carsJson = await _carBookingService.fetchAvailableCars(
//         _selectedService!,
//         selectedCategory!,
//         startDate!,
//       );
//
//       // Map the dynamic list to List<Car>
//       List<Car> cars = carsJson.map((carJson) => Car.fromJson(carJson)).toList();
//
//       // Navigate to CarListPage and pass the List<Car>
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CarListPage(availableCars: cars), // Pass List<Car>
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//
//
// }
