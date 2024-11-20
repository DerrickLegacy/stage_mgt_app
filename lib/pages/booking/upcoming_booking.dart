import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/booking.dart';
import 'package:stage_mgt_app/backend/services/booking_service.dart';

class UpcomingBookings extends StatefulWidget {
  const UpcomingBookings({super.key});

  @override
  State<UpcomingBookings> createState() => _UpcomingBookingsState();
}

class _UpcomingBookingsState extends State<UpcomingBookings> {
  GoogleMapController? mapController;
  final bookingService = BookingService();

  final TextEditingController _upFromController = TextEditingController();
  final TextEditingController _upToController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _upPassengerController = TextEditingController();
  final TextEditingController _upDistanceController = TextEditingController();
  final TextEditingController _upTimeController = TextEditingController();
  final TextEditingController _upContactController = TextEditingController();
  final TextEditingController _upEmailController = TextEditingController();
  late final String upcomingBookingID;

  LatLng? _fromCoordinates;
  LatLng? _toCoordinates;
  Set<Polyline> _polylines = {};
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    loadUpcomingTravels();
  }

  Future<String> getUserProperty(String property) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(property) ?? '';
  }

  void cancelUpcomingBooking(String upcomingBookingID) async {
    bool? confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Cancellation"),
          content: const Text(
              "Are you sure you want to cancel this upcoming booking?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed != null && confirmed) {
      try {
        await bookingService.cancelBooking(upcomingBookingID);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Booking canceled successfully")),
        );

        _upFromController.clear();
        _upToController.clear();
        _upPassengerController.clear();
        _upDistanceController.clear();
        _upTimeController.clear();
        _upContactController.clear();
        _upEmailController.clear();
        setState(() {
          _polylines = {};
          _fromCoordinates = null;
          _toCoordinates = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error canceling booking: $e")),
        );
      }
    }
  }

  Future<void> loadUpcomingTravels() async {
    try {
      List<BookingModel> upcomingBookings = await bookingService
          .getUpcomingBookings(await getUserProperty("userId"));

      if (upcomingBookings.isNotEmpty) {
        var upcomingBooking = upcomingBookings[0];
        setState(() {
          _upFromController.text = upcomingBooking.from;
          _upToController.text = upcomingBooking.to;
          _dateController.text = upcomingBooking.travelDate;
          _upPassengerController.text = upcomingBooking.numberOfPassengers;
          _upDistanceController.text = upcomingBooking.distance;
          _upTimeController.text = upcomingBooking.travelTime;
          _upContactController.text = upcomingBooking.contactNumber;
          _upEmailController.text = upcomingBooking.emailAddress;
          upcomingBookingID = upcomingBooking.bookingId;
        });

        await _geocodeLocations(_upFromController.text, _upToController.text);
      }
    } catch (e) {
      print('Error loading upcoming travels: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading upcoming travels: $e')),
      );
    }
  }

  Future<void> _geocodeLocations(String from, String to) async {
    try {
      List<Location> fromLocations = await locationFromAddress(from);
      List<Location> toLocations = await locationFromAddress(to);

      if (fromLocations.isNotEmpty && toLocations.isNotEmpty) {
        setState(() {
          _fromCoordinates = LatLng(
              fromLocations.first.latitude, fromLocations.first.longitude);
          _toCoordinates =
              LatLng(toLocations.first.latitude, toLocations.first.longitude);

          _polylines = {
            Polyline(
              polylineId: const PolylineId('route'),
              points: [_fromCoordinates!, _toCoordinates!],
              color: Colors.red,
              width: 5,
            ),
          };
        });

        if (mapController != null && _isMapReady) {
          await mapController!.animateCamera(
            CameraUpdate.newLatLngBounds(
              LatLngBounds(
                southwest: LatLng(
                  _fromCoordinates!.latitude < _toCoordinates!.latitude
                      ? _fromCoordinates!.latitude
                      : _toCoordinates!.latitude,
                  _fromCoordinates!.longitude < _toCoordinates!.longitude
                      ? _fromCoordinates!.longitude
                      : _toCoordinates!.longitude,
                ),
                northeast: LatLng(
                  _fromCoordinates!.latitude > _toCoordinates!.latitude
                      ? _fromCoordinates!.latitude
                      : _toCoordinates!.latitude,
                  _fromCoordinates!.longitude > _toCoordinates!.longitude
                      ? _fromCoordinates!.longitude
                      : _toCoordinates!.longitude,
                ),
              ),
              100.0,
            ),
          );
        }
      }
    } catch (e) {
      print('Error geocoding locations: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error geocoding locations: $e')),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      _isMapReady = true;
      if (_fromCoordinates != null && _toCoordinates != null) {
        _geocodeLocations(_upFromController.text, _upToController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Upcoming Travel'),
            SizedBox(width: 10),
            Icon(Icons.flight_takeoff, color: Colors.white),
          ],
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _fromCoordinates ?? const LatLng(1.3733, 32.2903),
                  zoom: 8.0,
                ),
                polylines: _polylines,
                markers: _fromCoordinates != null && _toCoordinates != null
                    ? {
                        Marker(
                          markerId: const MarkerId('from'),
                          position: _fromCoordinates!,
                          infoWindow: InfoWindow(title: _upFromController.text),
                        ),
                        Marker(
                          markerId: const MarkerId('to'),
                          position: _toCoordinates!,
                          infoWindow: InfoWindow(title: _upToController.text),
                        ),
                      }
                    : {},
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextField(
                        "From",
                        Icons.location_on,
                        _upFromController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10.0),
                      buildTextField(
                        "To",
                        Icons.location_on,
                        _upToController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _dateController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'Date',
                                prefixIcon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: buildTextField(
                              "Number of Passengers",
                              Icons.person,
                              _upPassengerController,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      buildTextField(
                        "Approximate Distance",
                        Icons.social_distance,
                        _upDistanceController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10.0),
                      buildTextField(
                        "Approximate Travel Time",
                        Icons.access_time,
                        _upTimeController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: buildTextField(
                              "Contact Number",
                              Icons.phone,
                              _upContactController,
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: buildTextField(
                              "Email Address",
                              Icons.email,
                              _upEmailController,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const SizedBox(width: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              cancelUpcomingBooking(upcomingBookingID);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red[700],
                              shadowColor: Colors.blueAccent,
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool readOnly = false}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
