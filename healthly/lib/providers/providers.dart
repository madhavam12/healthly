import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<String> userType = StateProvider((ref) {
  return "";
});

StateProvider<String> selectedCountry = StateProvider((ref) {
  return "India";
});
