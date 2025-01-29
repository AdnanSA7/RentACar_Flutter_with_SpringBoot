import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:project_practice/model/car_booking_show.dart';
import 'package:project_practice/model/car_booking_show_final.dart';

import 'Service/payment_service.dart';
import 'colors.dart';
import 'custom_app_bar.dart';

class PaymentPage extends StatefulWidget {
  final CarBookingShow bookingResponse;

  const PaymentPage({super.key, required this.bookingResponse});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final booking = widget.bookingResponse;

    return Scaffold(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildBookingDetailRow('Booking ID:', '${booking.id}'),
            _buildBookingDetailRow('Car ID:', '${booking.carId}'),
            _buildBookingDetailRow('Rental Type:', booking.rentalType),
            _buildBookingDetailRow('Start Date:', booking.startDate.toString()),
            _buildBookingDetailRow('End Date:', booking.endDate.toString()),
            _buildBookingDetailRow('Pickup Location:', booking.pickupLocation),
            _buildBookingDetailRow('Drop-off Location:', '${booking.dropOffLocation}'),
            _buildBookingDetailRow('Hours:', booking.hours?.toString() ?? 'N/A'),
            _buildBookingDetailRow('Total Cost:', '\$${booking.cost.toStringAsFixed(2)}'),
            _buildBookingDetailRow(
              'Additional Services:',
              booking.additionalServiceName.isNotEmpty
                  ? booking.additionalServiceName.join(', ')
                  : 'None',
            ),
            _buildBookingDetailRow('Driver Name:', booking.driverFirstName != null
                ? '${booking.driverFirstName} ${booking.driverLastName}'
                : 'No Driver Assigned'),
            _buildBookingDetailRow(
              'Admin Approval:',
              booking.adminApproval ? 'Approved' : 'Pending',
            ),
            _buildBookingDetailRow('Service Start:', booking.serviceStart ? 'Started' : 'Not Started'),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showPaymentModal(context, booking.id, booking.cost);
                },
                child: const Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build rows for booking details
  Widget _buildBookingDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // void _showPaymentModal(BuildContext context, int bookingId, double cost) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           left: 16.0,
  //           right: 16.0,
  //           top: 16.0,
  //           bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Center(
  //               child: Text(
  //                 'Complete Payment',
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //             Text('Booking ID: $bookingId', style: const TextStyle(fontSize: 16)),
  //             Text('Amount to Pay: \$${cost.toStringAsFixed(2)}',
  //                 style: const TextStyle(fontSize: 16)),
  //             const SizedBox(height: 20),
  //             const Text('Select Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //             const SizedBox(height: 10),
  //             ListTile(
  //               leading: Image.asset('assets/images/bkash_logo.png', height: 30),
  //               title: const Text('Bkash'),
  //               onTap: () {
  //                 Navigator.pop(context); // Close the modal
  //                 _showBkashPaymentDialog(context, bookingId, cost);
  //               },
  //             ),
  //             ListTile(
  //               leading: Image.asset('assets/images/nagad_logo.png', height: 30),
  //               title: const Text('Nagad'),
  //               onTap: () {
  //                 Navigator.pop(context); // Close the modal
  //                 _showNagadPaymentDialog(context, bookingId, cost);
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.credit_card, color: AppColors.primary),
  //               title: const Text('Credit/Debit Card'),
  //               onTap: () {
  //                 Navigator.pop(context); // Close the modal
  //                 _showCardPaymentDialog(context, bookingId, cost);
  //               },
  //             ),
  //             const SizedBox(height: 10),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // void _showBkashPaymentDialog(BuildContext context, int bookingId, double cost) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Bkash Payment'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text('Enter your Bkash number:'),
  //             const SizedBox(height: 10),
  //             TextField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Bkash Number',
  //                 border: OutlineInputBorder(),
  //               ),
  //               keyboardType: TextInputType.phone,
  //             ),
  //             const SizedBox(height: 10),
  //             const Text('We will send a payment request to your Bkash app.'),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text('Bkash payment initiated.')),
  //               );
  //             },
  //             child: const Text('Confirm'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // void _showNagadPaymentDialog(BuildContext context, int bookingId, double cost) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Nagad Payment'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text('Enter your Nagad number:'),
  //             const SizedBox(height: 10),
  //             TextField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Nagad Number',
  //                 border: OutlineInputBorder(),
  //               ),
  //               keyboardType: TextInputType.phone,
  //             ),
  //             const SizedBox(height: 10),
  //             const Text('We will send a payment request to your Nagad app.'),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text('Nagad payment initiated.')),
  //               );
  //             },
  //             child: const Text('Confirm'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // void _showCardPaymentDialog(BuildContext context, int bookingId, double cost) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Card Payment'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Card Number',
  //                 border: OutlineInputBorder(),
  //               ),
  //               keyboardType: TextInputType.number,
  //             ),
  //             const SizedBox(height: 10),
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Expiry Date (MM/YY)',
  //                 border: OutlineInputBorder(),
  //               ),
  //               keyboardType: TextInputType.datetime,
  //             ),
  //             const SizedBox(height: 10),
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'CVV',
  //                 border: OutlineInputBorder(),
  //               ),
  //               keyboardType: TextInputType.number,
  //               obscureText: true,
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text('Card payment successful!')),
  //               );
  //             },
  //             child: const Text('Pay Now'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  void _showPaymentModal(BuildContext context, int bookingId, double cost) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Complete Payment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Text('Booking ID: $bookingId', style: const TextStyle(fontSize: 16)),
              Text('Total Amount: \$${cost.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              Text('Amount to Pay: \$${(cost*0.2).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text('Select Payment Method',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ListTile(
                leading: Image.asset('assets/images/bkash_logo.png', height: 30),
                title: const Text('Bkash'),
                onTap: () {
                  Navigator.pop(context);
                  _showBkashPaymentDialog(context, bookingId, cost);
                },
              ),
              ListTile(
                leading: Image.asset('assets/images/nagad_logo.png', height: 30),
                title: const Text('Nagad'),
                onTap: () {
                  Navigator.pop(context);
                  _showNagadPaymentDialog(context, bookingId, cost);
                },
              ),
              ListTile(
                leading: Icon(Icons.credit_card, color: AppColors.primary),
                title: const Text('Credit/Debit Card'),
                onTap: () {
                  Navigator.pop(context);
                  _showCardPaymentDialog(context, bookingId, cost);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showBkashPaymentDialog(BuildContext context, int bookingId, double cost) {
    TextEditingController transactionController = TextEditingController();
    String bkashNumber = "013XXXXXXXX"; // Fixed Bkash number

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bkash Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bkash Number: $bkashNumber', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: transactionController,
                decoration: const InputDecoration(
                  labelText: 'Enter Transaction ID',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _processPayment(context, bookingId, cost, "Bkash", transactionController.text);
              },
              child: const Text('Complete Payment'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showNagadPaymentDialog(BuildContext context, int bookingId, double cost) {
    TextEditingController transactionController = TextEditingController();
    String nagadNumber = "017XXXXXXXX"; // Fixed Nagad number

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nagad Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nagad Number: $nagadNumber', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: transactionController,
                decoration: const InputDecoration(
                  labelText: 'Enter Transaction ID',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _processPayment(context, bookingId, cost, "Nagad", transactionController.text);
              },
              child: const Text('Complete Payment'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showCardPaymentDialog(BuildContext context, int bookingId, double cost) {
    TextEditingController transactionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Card Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: transactionController,
                decoration: const InputDecoration(
                  labelText: 'Enter Transaction ID',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _processPayment(context, bookingId, cost, "Card", transactionController.text);
              },
              child: const Text('Pay Now'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _processPayment(BuildContext context, int bookingId, double cost, String method, String transactionId) async {
    if (transactionId.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid transaction ID")),
        );
      }
      return;
    }

    try {
      final CarBookingShowFinal response = await PaymentService().initiatePayment(
        bookingId: bookingId,
        paymentMethod: method,
        transactionId: transactionId,
        initialAmount: cost * 0.2,
        amount: cost,
      );

      if (response != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$method Payment Successful!")),
          );

          // ✅ Close any open dialogs before showing the response
          Navigator.pop(context);

          // ✅ Show the success dialog with the response
          _showPaymentSuccessDialog(context, response.toJson());
        }
      } else {
        throw Exception("Payment failed");
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment Failed: $e")),
        );
        print("Payment Failed: $e");
      }
    }
  }


  // Function to show payment success details with an invoice option
  void _showPaymentSuccessDialog(BuildContext context, Map<String, dynamic> response) {
    if (!context.mounted) return; // Ensure the widget is still in the tree
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Booking ID: ${response["id"]}', style: const TextStyle(fontSize: 16)),
              Text('Car: ${response["brand"]} ${response["model"]}', style: const TextStyle(fontSize: 16)),
              Text('Rental Type: ${response["rentalType"]}', style: const TextStyle(fontSize: 16)),
              Text('Start Date: ${response["startDate"]}', style: const TextStyle(fontSize: 16)),
              Text('End Date: ${response["endDate"]}', style: const TextStyle(fontSize: 16)),
              Text('Pickup Location: ${response["pickupLocation"]}', style: const TextStyle(fontSize: 16)),
              Text('Drop-off Location: ${response["dropOffLocation"] ?? "N/A"}', style: const TextStyle(fontSize: 16)),
              Text('Driver: ${response["driverFirstName"]} ${response["driverLastName"]}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)), // ✅ Added Driver Name
              Text('Total Cost: \$${response["totalCost"]}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Paid Amount: \$${response["initialAmount"]}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              Text('Payment Method: ${response["paymentMethod"]}', style: const TextStyle(fontSize: 16)),
              Text('Transaction ID: ${response["transactionId"]}', style: const TextStyle(fontSize: 16, color: Colors.blue)),
              const SizedBox(height: 10),
              const Text("Additional Services:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ...List.generate(response["additionalServiceName"]?.length ?? 0, (index) {
                return Text("- ${response["additionalServiceName"][index]}", style: const TextStyle(fontSize: 14));
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _generateInvoice(response);
              },
              child: const Text('View Invoice'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }



// Function to generate and display an invoice
  Future<void> _generateInvoice(Map<String, dynamic> response) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Booking ID: ${response["id"]}'),
              pw.Text('Car: ${response["brand"]} ${response["model"]}'),
              pw.Text(
                'Driver: ${response["driverFirstName"] ?? "Unknown"} ${response["driverLastName"] ?? ""}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.blue),
              ),
              pw.Text('Pickup Location: ${response["pickupLocation"]}'),
              pw.Text('Drop-off Location: ${response["dropOffLocation"] ?? "N/A"}'),
              pw.Text('Total Cost: \$${response["totalCost"]}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('Paid Amount: \$${response["initialAmount"]}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.green)),
              pw.Text('Payment Method: ${response["paymentMethod"]}'),
              pw.Text('Transaction ID: ${response["transactionId"]}'),
              pw.SizedBox(height: 10),
            ],
          );
        },
      ),
    );

    if (kIsWeb) {
      // ✅ Web: Allow user to preview & print the invoice
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } else {
      // ✅ Mobile/Desktop: Save, share, or print
      await Printing.sharePdf(bytes: await pdf.save(), filename: "invoice_${response["id"]}.pdf");
    }
  }

}


