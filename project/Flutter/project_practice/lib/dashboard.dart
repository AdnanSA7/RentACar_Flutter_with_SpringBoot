import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Service/CarBookingService.dart';
import 'colors.dart';
import 'custom_app_bar.dart';
import 'model/car_booking_show.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late Future<List<CarBookingShow>> _bookings;
  int? _userId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId != null) {
      setState(() {
        _userId = userId;
        _bookings = CarBookingService().getBookingsByUserId(userId);
      });
    }
  }

  /// ✅ **Define `_refreshBookings()`**
  Future<void> _refreshBookings() async {
    if (_userId != null) {
      setState(() {
        _bookings = CarBookingService().getBookingsByUserId(_userId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: "User Dashboard",
        gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
        ),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshBookings, // ✅ Refresh button
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshBookings, // ✅ Allows user to pull-to-refresh
        child: _userId == null
            ? const Center(child: CircularProgressIndicator()) // Wait for userId to load
            : FutureBuilder<List<CarBookingShow>>(
          future: _bookings,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No bookings found"));
            }
            List<CarBookingShow> bookings = snapshot.data!;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    border: TableBorder.all(),
                    columns: const [
                      DataColumn(label: Text("Booking ID")),
                      DataColumn(label: Text("Car ID")),
                      DataColumn(label: Text("Rental Type")),
                      DataColumn(label: Text("Start Date")),
                      DataColumn(label: Text("End Date")),
                      DataColumn(label: Text("Pickup Location")),
                      DataColumn(label: Text("Dropoff Location")),
                      DataColumn(label: Text("Cost")),
                      DataColumn(label: Text("Status")),
                    ],
                    rows: bookings.map((booking) {
                      return DataRow(cells: [
                        DataCell(Text(booking.id.toString())),
                        DataCell(Text(booking.carId.toString())),
                        DataCell(Text(booking.rentalType)),
                        DataCell(Text(booking.startDate.toString())),
                        DataCell(Text(booking.endDate.toString())),
                        DataCell(Text(booking.pickupLocation)),
                        DataCell(Text('${booking.dropOffLocation}')),
                        DataCell(Text("\$${booking.cost.toStringAsFixed(2)}")),
                        DataCell(Text(booking.status.toString())),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
