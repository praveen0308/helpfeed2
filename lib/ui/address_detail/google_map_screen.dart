import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  LatLng _center = const LatLng(19.0454229, 72.8881396);
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId("Pickup Location"),
      position: LatLng(19.0454229, 72.8881396),
      icon: BitmapDescriptor.defaultMarker,
    )
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    _determinePosition().then((value) {
      setState(() {
        _center = LatLng(value.latitude, value.longitude);
        _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: const MarkerId("Pickup Location"),
          position: _center,

          icon: BitmapDescriptor.defaultMarker,
        ));
        mapController
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: _center,
          zoom: 15.0,
        )));
      });


    });
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _onAddMarkerButtonPressed(LatLng latlang) {
    setState(() {
      _center = LatLng(latlang.latitude, latlang.longitude);
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: const MarkerId("Pickup Location"),
        position: latlang,

        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 72.0),
      child: GoogleMap(

        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),

        onTap: (latlang) {
          if (_markers.isNotEmpty) {
            _markers.clear();
          }

          _onAddMarkerButtonPressed(latlang);
        },

        markers: _markers,
      ),
    );
  }
}
