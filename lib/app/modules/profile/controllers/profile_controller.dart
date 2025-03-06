import 'package:get/get.dart';
import 'package:school_mobile/app/data/models/user_model.dart';
import 'package:school_mobile/app/modules/login/controllers/login_controller.dart';

class ProfileController extends GetxController {
  final LoginController loginController = Get.find<LoginController>();

  Rxn<UserModel> get user => loginController.user;
}
