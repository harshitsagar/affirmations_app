// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_catch_error

import 'dart:developer';

import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/keychain.dart';
import 'package:affirmations_app/app/modules/authentication/login/controllers/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// File to handle social authentication for signed in users
class SignInSocialAuth {
  static final LoginController signInController = Get.find<LoginController>();
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future signInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        log(googleSignInAccount.toString());
        log(googleSignInAuthentication.idToken.toString());
        await signInController.googleSignIn(
          name: googleSignInAccount.displayName!,
          email: googleSignInAccount.email,
          picture: googleSignInAccount.photoUrl,
          socialId: googleSignInAccount.id,
          socialToken: googleSignInAuthentication.idToken!,
          socialIdentifier: getSocialIdentifier(
            SocialIdentifier.google,
          ),
          context: context,
        );
      } else {
        AppConstants.showSnackbar(
          headText: "Failed",
          content: "No account is selected",
          position: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      log(
        e.message.toString(),
      );
    } catch (e) {
      if (kDebugMode) {
        print(
          e.toString(),
        );
      }
    }
  }

  static Future signInWithFacebook({
    required BuildContext context,
  }) async {
    try {
      await FacebookAuth.instance.logOut();
      await FacebookAuth.instance.login(
        permissions: const ['email', 'public_profile'],
      ).then((value) async {
        final AccessToken? accessToken =
            await FacebookAuth.instance.accessToken;
        if (accessToken != null) {
          log("Access Token: ${accessToken.toJson().toString()}");
        } else {
          log("Failed to retrieve access token");
        }

        await FacebookAuth.instance.getUserData().then((data) async {
          log(value.toString());
          await signInController.facebookSignIn(
            name: data["name"] ?? "",
            email: data["email"] ?? "",
            socialId: data["id"] ?? "",
            socialToken: value.accessToken?.tokenString ?? "",
            socialIdentifier: getSocialIdentifier(
              SocialIdentifier.facebook,
            ),
            context: context,
          );
        });
      });
      // final facebookLogin = FacebookLogin();
      // facebookLogin.logOut();
      // final res = await facebookLogin.logIn(
      //   permissions: [
      //     FacebookPermission.publicProfile,
      //     FacebookPermission.email,
      //   ],
      // );
      // switch (res.status) {
      //   case FacebookLoginStatus.success:
      //     final String socialToken = res.accessToken!.token;
      //     final String socialId = res.accessToken!.userId;
      //     final profile = await facebookLogin.getUserProfile();
      //     final email = await facebookLogin.getUserEmail();
      //
      //     if (email != null) {
      //       log('And your email is $email');
      //     }
      //     await signInController.facebookSignIn(
      //       name: profile!.name!,
      //       email: email!,
      //       socialId: socialId,
      //       socialToken: socialToken,
      //       socialIdentifier: getSocialIdentifier(
      //         SocialIdentifier.facebook,
      //       ),
      //       context: context,
      //     );
      //
      //     break;
      //   case FacebookLoginStatus.cancel:
      //     // User cancel log in
      //     log('Error while log in: ${res.error}');
      //     break;
      //   case FacebookLoginStatus.error:
      //     // Log in failed
      //     log('Error while log in: ${res.error}');
      //     break;
      // }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  static Future signInWithApple({
    required BuildContext context,
  }) async {
    try {
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      ).then(
        (appleCredential) async {
          final credential = await getKeyChain();
          if (credential == null) {
            putKeyChain(
              name: appleCredential.givenName,
              familyName: appleCredential.familyName,
              email: appleCredential.email,
            );
          }

          OAuthProvider("apple.com").credential(
            idToken: appleCredential.identityToken,
          );
          // log("APPLE LOGIN givenName: ${appleCredential.givenName ?? credential!["name"]} ");
          // log("APPLE LOGIN familyName: ${appleCredential.familyName ?? credential!["familyName"]}");
          // log("APPLE LOGIN identityToken: ${appleCredential.identityToken} ");
          // log("APPLE LOGIN userIdentifier: ${appleCredential.userIdentifier} ");
          // log("APPLE LOGIN email: ${appleCredential.email ?? credential!["email"]} ");
          // log("APPLE LOGIN state: ${appleCredential.state} ");
          // log("APPLE LOGIN authorizationCode: ${appleCredential.authorizationCode}");
          await signInController.appleSignIn(
            name:
                '${appleCredential.givenName ?? credential!["name"]} ${appleCredential.familyName ?? credential!["familyName"]}',
            email: appleCredential.email ?? credential!["email"],
            picture: null,
            socialId: appleCredential.userIdentifier ?? "",
            socialToken: appleCredential.identityToken ?? "",
            socialIdentifier: getSocialIdentifier(
              SocialIdentifier.apple,
            ),
            context: context,
          );
        },
      ).catchError((e) {
        if (e.code == AuthorizationErrorCode.canceled) {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: "Apple id not selected.",
            position: SnackPosition.BOTTOM,
          );
        }
        log(e.toString());
      });
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

}
