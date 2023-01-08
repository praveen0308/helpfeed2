import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpfeed2/ui/address_detail/google_map_screen.dart';
import 'package:helpfeed2/utils/toaster.dart';

class AddressDetailScreen extends StatefulWidget {
  const AddressDetailScreen({Key? key}) : super(key: key);

  @override
  State<AddressDetailScreen> createState() => _AddressDetailScreenState();
}

class _AddressDetailScreenState extends State<AddressDetailScreen> {
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text("Pick Location"),),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: GoogleMap(
                  onTap: (val){
                    _onAddMarkerButtonPressed(val);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 12,
                  ),
                  markers: _markers,
                  onMapCreated: _onMapCreated,
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ElevatedButton(onPressed: () {
                    Navigator.pop(context,_center);
                  }, child: const Text("Confirm")))
            ],
          ),),
    );
  }
}
