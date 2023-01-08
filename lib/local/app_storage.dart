import 'dart:ffi';

import 'package:helpfeed2/models/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage{

  static const _userId = "userId";
  static const _category = "category";
  static const _role = "role";
  static const _name = "name";
  static const _webUrl = "webUrl";
  static const _personName = "personName";
  static const _phoneNumber = "phoneNumber";
  static const _description = "description";
  static const _addressLine1 = "addressLine1";
  static const _addressLine2 = "addressLine2";
  static const _city = "city";
  static const _pinCode = "pinCode";
  static const _state = "state";
  static const _longitude = "longitude";
  static const _latitude = "latitude";

  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userId,userId);
  }
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userId);
  }

  static Future<void> setCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_category,category);
  }


  static Future<String?> getCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_category);
  }

  static Future<void> setRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_role,role);
  }


  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_role);
  }

  static Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_name,name);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_name);
  }


  static Future<void> setPersonName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_personName,name);
  }
  static Future<String?> getPersonName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_personName);
  }

  static Future<void> setPhoneNumber(String number) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneNumber,number);
  }
  static Future<String?> getPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneNumber);
  }


  static Future<void> setWebUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_webUrl,url);
  }
  static Future<String?> getWebUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_webUrl);
  }


  static Future<void> setDescription(String description) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_description,description);
  }
  static Future<String?> getDescription() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_description);
  }


  static Future<void> setAddressLine1(String txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_addressLine1,txt);
  }
  static Future<String?> getAddressLine1() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_addressLine1);
  }



  static Future<void> setAddressLine2(String txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_addressLine2,txt);
  }
  static Future<String?> getAddressLine2() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_addressLine2);
  }



  static Future<void> setCity(String txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_city,txt);
  }
  static Future<String?> getCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_city);
  }

  static Future<String?> getLocationTag() async {
    final prefs = await SharedPreferences.getInstance();
    return "${prefs.getString(_city)}-${prefs.getInt(_pinCode)}";
  }



  static Future<void> setPinCode(int txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_pinCode,txt);
  }
  static Future<int?> getPinCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_pinCode);
  }



  static Future<void> setStateProvince(String txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_state,txt);
  }
  static Future<String?> getStateProvince() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_state);
  }



  static Future<void> setLongitude(double txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_longitude,txt);
  }
  static Future<double?> getLongitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_longitude);
  }



  static Future<void> setLatitude(double txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latitude,txt);
  }
  static Future<double?> getLatitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_latitude);
  }


  static Future<void> storeAddress(AddressModel address) async {
    await setAddressLine1(address.addressLine1??"");
    await setAddressLine2(address.addressLine2??"");
    await setCity(address.city??"");
    await setPinCode(address.pincode??0);
    await setStateProvince(address.state??"");
    await setLongitude(address.longitude!);
    await setLatitude(address.latitude!);
  }





}