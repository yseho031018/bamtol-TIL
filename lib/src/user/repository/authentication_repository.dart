import 'dart:convert';
import 'dart:math';

import 'package:bamtol/src/user/model/user_model.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationRepository extends GetxService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository(this._firebaseAuth);

  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map<UserModel?>((user) {
      return user == null ? null : UserModel(uid: user.uid);
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      // 웹과 모바일 모두 호환되는 방식
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      
      // 웹에서는 팝업, 모바일에서는 리다이렉트 방식 사용
      await _firebaseAuth.signInWithPopup(googleProvider);
    } catch (e) {
      print('Google Sign-In Error: $e');
      rethrow;
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    await _firebaseAuth.signInWithCredential(oauthCredential);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}