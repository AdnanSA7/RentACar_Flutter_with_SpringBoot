import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:project_practice/Service/CarBookingService.dart';
import 'package:project_practice/Service/api_service.dart';
import 'package:project_practice/model/car_booking_request.dart';
import 'package:project_practice/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';
import 'custom_app_bar.dart';
import 'model/Car.dart';
import 'model/additional_services.dart';
import 'package:http/http.dart' as http;


class CarListPage extends StatefulWidget {
  final List<Car> availableCars;
  final List extra;

  // Constructor to accept availableCars data
  const CarListPage({super.key, required this.availableCars, required this.extra});

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  late int _userId;
  late List<Car> _availableCars;
  late List _extra;
  late Future<List<AdditionalServices>> _additionalServices;
  List<int> _selectedAdditionalServices = [];
  final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  late Map<String,dynamic> carBookingShow;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    _availableCars = widget.availableCars; // Initialize the car list
    _extra = widget.extra;
    _loadUserIdFromLocalStorage();
    _additionalServices = ApiService().fetchAdditionalServices();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
  }

  // Load userId from local storage
  Future<void> _loadUserIdFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getInt('userId'); // getInt directly returns an int

    if (storedUserId != null) {
      setState(() {
        _userId = storedUserId; // Directly use storedUserId without parsing
      });
    }
  }


  // Function to show the details in a modal bottom sheet
  void _showCarDetails(Car car, var info) {
    // The controller for the hours input field
    TextEditingController hoursController = TextEditingController(text: _extra.isNotEmpty ? _extra[0].toString() : '0');

    // The controller for the additional services input field
    TextEditingController additionalServiceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        return Padding(
          padding:EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Details Section
              Text(
                'Car Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text('Brand: ${car.brand}', style: TextStyle(fontSize: 16)),
              Text('Model: ${car.model}', style: TextStyle(fontSize: 16)),
              Text('Category: ${car.categoryName}', style: TextStyle(fontSize: 16)),
              Text('Rental Type: ${car.rentalTypeName}', style: TextStyle(fontSize: 16)),
              Text('Start Date: ${info[3]}', style: TextStyle(fontSize: 16)),
              Text('Start Location: ${info[1]}', style: TextStyle(fontSize: 16)),
              Text('End Date: ${info[4]}', style: TextStyle(fontSize: 16)),
              Text('End Location: ${info[2]}', style: TextStyle(fontSize: 16)),
              Text('Rate: \$${car.serviceRate}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              // Additional Services Dropdown
              Text('Additional Services:', style: TextStyle(fontSize: 16)),
              FutureBuilder<List<AdditionalServices>>(
                future: _additionalServices,
                builder: (BuildContext context, AsyncSnapshot<List<AdditionalServices>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No additional services available');
                  } else {
                    // Store fetched services
                    List<AdditionalServices> services = snapshot.data!;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: MultiSelectDialogField(
                            items: services.map((service) => MultiSelectItem<AdditionalServices>(service, service.name)).toList(),
                            title: Text("Select Additional Services"),
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            buttonText: Text("Select Services"),
                            onConfirm: (values) {
                              setState(() {
                                _selectedAdditionalServices = List<int>.from(values);
                              });
                            },
                            initialValue: _selectedAdditionalServices,
                          ),
                        ),
                      ],
                    );
                  }
                  // else {
                  //   List<AdditionalServices> services = snapshot.data!;
                  //   return DropdownButton<AdditionalServices>(
                  //     hint: Text('Select a service'),
                  //     value: additionalServiceController.text.isEmpty ? null : services.firstWhere((service) => service.name == additionalServiceController.text, orElse: () => services.first),
                  //     onChanged: (AdditionalServices? newValue) {
                  //       setState(() {
                  //         additionalServiceController.text = newValue?.name ?? '';
                  //       });
                  //     },
                  //     items: services.map<DropdownMenuItem<AdditionalServices>>((AdditionalServices service) {
                  //       return DropdownMenuItem<AdditionalServices>(
                  //         value: service,
                  //         child: Text(service.name),
                  //       );
                  //     }).toList(),
                  //   );
                  // }
                },
              ),
              SizedBox(height: 20),

              // Hours Input Field
              Text('Hours:', style: TextStyle(fontSize: 16)),
              TextField(
                controller: hoursController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of hours',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Button to Save or Close
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Close the bottom sheet without saving
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                  ElevatedButton(
                    onPressed: () async {

                        // final url = 'http://localhost:8080/api/bookings'; // Replace with your actual URL
                        //
                        // final response = await http.post(
                        //   Uri.parse(url),
                        //   headers: {'Content-Type': 'application/json'},
                        //   body: json.encode(
                        //       {
                        //         'carId': car.id,
                        //         'userId': _userId,
                        //         'rentalType': car.rentalTypeName,
                        //         'startDate': dateFormat.format(info[3]).toString(),
                        //         'endDate': info[4] !=null ? dateFormat.format(info[4]).toString() : null,
                        //         'pickupLocation': info[1],
                        //         'dropOffLocation': info[2],
                        //         'hours': hoursController.text.isNotEmpty ? int.parse(hoursController.text) : null,
                        //         'distance': '',
                        //         'additionalServiceIds': [],
                        //       }
                        //   ),
                        // );
                        //
                        // if (response.statusCode == 200) {
                        //   // If the request is successful, parse the response body
                        //   // return CarBookingShow.fromJson(json.decode(response.body));
                        //   var responseData = jsonDecode(response.body);
                        //   carBookingShow = Map<String,dynamic>.from(responseData);
                        //   print(carBookingShow);
                        // } else {
                        //   // Handle error response
                        //   throw Exception('Failed to create booking');
                        // }

                      try {
                        final bookingRequest = CarBookingRequest(
                          carId: car.id,
                          userId: _userId,
                          rentalType: car.rentalTypeName,
                          startDate: dateFormat.format(info[3]).toString(),
                          endDate: info[4] !=null ? dateFormat.format(info[4]).toString() : null,
                          pickupLocation: info[1],
                          dropOffLocation: info[2],
                          hours: hoursController.text.isNotEmpty ? int.parse(hoursController.text) : null,
                          additionalServiceIds: _selectedAdditionalServices
                        );

                        print(bookingRequest.toJson());

                        final bookingResponse = await CarBookingService().createCarBooking(bookingRequest);

                        // Custom Toast Position
                        fToast.showToast(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width,
                                color: Colors.greenAccent,
                                child: Text("Booking Successful!"),
                              ),
                            ),
                            gravity: ToastGravity.TOP,
                            toastDuration: Duration(seconds: 2));
                        // 🎉 Show a toast notification on success
                        // Fluttertoast.showToast(
                        //   msg: "Booking Successful!",
                        //   toastLength: Toast.LENGTH_LONG,
                        //   gravity: ToastGravity.TOP, // 🔥 Show at the top
                        //   backgroundColor: Colors.green,
                        //   textColor: Colors.white,
                        //   fontSize: 16.0,
                        // );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentPage(bookingResponse: bookingResponse)),
                        );
                      }
                      catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking failed: $e')));
                        print('Booking failed: $e');
                      }
                    },
                    child: Text('Book Car'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    int hours = _extra.isNotEmpty ? _extra[0] : 0;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Available Cars'),
      // ),
        appBar: GradientAppBar(
          title: "Available Cars",
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
      body: _availableCars.isEmpty
          ? Center(child: Text("No cars available"))
          : ListView.builder(
        itemCount: _availableCars.length,
        itemBuilder: (ctx, index) {
          final car = _availableCars[index];
          final image = base64Decode(car.carImage);
          final info = _extra;
          return SizedBox(
            height: 200,
            child: GestureDetector(
              onTap: () {
                _showCarDetails(car,info);
              },
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  fit: StackFit.expand, // Ensure that the background image fills the entire card
                  children: [
                    // Background image
                    Positioned.fill(
                      child: Image.memory(
                        image,
                        fit: BoxFit.cover, // Make sure the image covers the entire area
                      ),
                    ),
                    // A semi-transparent overlay to make text readable
                    Container(
                      color: Colors.black.withOpacity(0.5), // Semi-transparent black overlay
                    ),
                    // Details over the background image
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car.brand,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            car.model,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${car.categoryName} | Rental Type: ${car.rentalTypeName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Rate: \$${car.serviceRate}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
