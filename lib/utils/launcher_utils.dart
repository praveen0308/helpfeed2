
import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {

  static Future<void> openMap(double lat,double long) async {
    Uri uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);

    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openSMS(String msg) async {
    Uri uri = Uri.parse('sms:$msg');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);

    } else {
      throw 'Could not perform sms.';
    }
  }

  static Future<void> openPhone(String number) async {
    Uri uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);

    } else {
      throw 'Could not call.';
    }
  }

  static Future<void> openEmail(String emailId,String subject,String body) async {
    Uri uri = Uri.parse('mailto:$emailId?subject=$subject&body=$body');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);

    } else {
      throw 'Could not open the email.';
    }
  }

  static Future<void> openWebsite(String url) async {
    Uri uri = Uri.parse('https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);

    } else {
      throw 'Could not open the email.';
    }
  }



}