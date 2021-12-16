import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

void hitUrl({
  required String searchStr,
}) async {
  String url() {
    return searchStr;
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}
