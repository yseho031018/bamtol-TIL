import 'package:bamtol/src/user/repository/authentication_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthenticationRepository authenticationRepository;
  LoginController(this.authenticationRepository);

  void googleLogin() async {
    try {
      await authenticationRepository.signInWithGoogle();
      // 로그인 성공 시 홈으로 이동
      Get.offAllNamed('/home');
    } catch (e) {
      print('Google Login Failed: $e');
      Get.snackbar('로그인 실패', '다시 시도해주세요.');
    }
  }

  void appleLogin() async {
    try {
      await authenticationRepository.signInWithApple();
      // 로그인 성공 시 홈으로 이동
      Get.offAllNamed('/home');
    } catch (e) {
      print('Apple Login Failed: $e');
      Get.snackbar('로그인 실패', '다시 시도해주세요.');
    }
  }
}