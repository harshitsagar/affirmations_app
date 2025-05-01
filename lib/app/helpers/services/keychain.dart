import 'package:flutter_keychain/flutter_keychain.dart';

// File to handle keychain operations
Future<Map<String, dynamic>?> getKeyChain() async {
  var email = await FlutterKeychain.get(key: "com.app.thryve-email");
  var name = await FlutterKeychain.get(key: "com.app.thryve-name");
  var familyName = await FlutterKeychain.get(key: "com.app.thryve-familyName");
  if (email == null && name == null && familyName == null) {
    return null;
  } else {
    return {
      "name": name ?? "",
      "email": email ?? "",
      "familyName": familyName ?? "",
    };
  }
}

putKeyChain({
  required String? name,
  required String? familyName,
  required String? email,
}) async {
  await FlutterKeychain.put(key: "com.app.thryve-email", value: email ?? "");
  await FlutterKeychain.put(key: "com.app.thryve-name", value: name ?? "");
  await FlutterKeychain.put(
      key: "com.app.thryve-familyName", value: familyName ?? "");
}
