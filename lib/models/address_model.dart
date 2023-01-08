class AddressModel {
  String? addressLine1;
  String? addressLine2;
  String? city;
  int? pincode;
  String? state;
  double? longitude;
  double? latitude;

  AddressModel({this.addressLine1, this.addressLine2, this.city, this.pincode,
      this.state,this.longitude,this.latitude});

  @override
  String toString() {
    return "$addressLine1, $addressLine2, $city-$pincode, $state";
  }

  Map<String, dynamic> toMap() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'pincode': pincode,
      'state': state,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressLine1: map['addressLine1'] as String?,
      addressLine2: map['addressLine2'] as String?,
      city: map['city'] as String?,
      pincode: map['pincode'] as int?,
      state: map['state'] as String?,
      longitude: map['longitude'] as double?,
      latitude: map['latitude'] as double?,
    );
  }
}
