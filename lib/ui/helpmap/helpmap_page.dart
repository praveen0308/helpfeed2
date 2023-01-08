import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpfeed2/res/app_images.dart';

import 'package:helpfeed2/utils/util_methods.dart';

import 'helpmap_page_cubit.dart';

class HelpMapPage extends StatefulWidget {
  const HelpMapPage({Key? key}) : super(key: key);

  @override
  State<HelpMapPage> createState() => _HelpMapPageState();
}

class _HelpMapPageState extends State<HelpMapPage> {
  late GoogleMapController mapController;

  final String myLocationID = "MyLocationID";
  LatLng _center = const LatLng(19.0454229, 72.8881396);
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId("MyLocationID"),
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
          markerId:  MarkerId(myLocationID),
          position: _center,

          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
              title: "You",
              snippet: "You are here!!"
            //  snippet: '5 Star Rating',
          ),
          onTap: (){
            mapController.showMarkerInfoWindow(MarkerId(myLocationID));
          }
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


  @override
  void initState() {
    BlocProvider.of<HelpMapPageCubit>(context).fetchReceivers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<HelpMapPageCubit, HelpMapPageState>(
          listener: (context, state) async {
            if(state is ReceivedReceivers){
              for (var element in state.receivers) {
                var latLng = LatLng(element.address!.latitude!, element.address!.longitude!);
                final Uint8List markerIcon = await UtilMethods.getBytesFromAsset(AppImages.marker2, 50);
                var marker = Marker(
                  markerId: MarkerId(element.userId!),
                  position: latLng,
                  icon: BitmapDescriptor.fromBytes(markerIcon),
                    infoWindow: InfoWindow(
                      title: "${element.name}(${element.contacts![0]})",
                      snippet: "${element.address!.addressLine1},${element.address!.addressLine2}",
                      onTap: (){
                        // Navigator.pushNamed(context, "/requestDetails",arguments: element);
                        Navigator.pushNamed(context, "/userProfile",
                            arguments: element.userId);
                      }
                    ),
                  onTap: (){

                    mapController.showMarkerInfoWindow(MarkerId(element.userId!));
                  }
                );

                _markers.add(marker);
                setState((){});
              }
            }
          },
          builder: (context, state) {
            if(state is LoadingReceivers){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GoogleMap(

              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 7,
              ),
              markers: _markers,
              onMapCreated: _onMapCreated,
            );
          },
        ),
      ),
    );
  }
}
