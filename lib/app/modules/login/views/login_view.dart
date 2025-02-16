import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_mobile/app/data/utils/color.dart';
import '../controllers/login_controller.dart';
import 'package:lottie/lottie.dart';

class LoginView extends GetView<LoginController> {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [mainColor, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 80), // Mengatur jarak atas
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Login or Sign up to access your account",
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              /// **Lottie Animation**
              SizedBox(
                height: 170, // Atur tinggi animasi
                child: Lottie.asset("assets/lotties/login2.json"),
              ),
              const SizedBox(
                  height: 30), // Mengatur jarak sebelum konten selanjutnya
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Color(0xFF1453A3),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Color(0xFF1453A3),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(text: "Login"),
                            Tab(text: "Register"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildLoginForm(),
                              _buildRegisterForm(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  /// Widget untuk Form Login
  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: Image.asset("assets/images/google.png", height: 24),
              label: const Text("Login with Google"),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.apple, color: Colors.black),
              label: const Text("Login with Apple"),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
                controller: loginEmailController,
                label: "Email Address",
                icon: Icons.email),
            const SizedBox(height: 10),
            _buildTextField(
                controller: loginPasswordController,
                label: "Password",
                icon: Icons.lock,
                isObscure: true),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot password?",
                    style: TextStyle(color: mainColor)),
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller.loginUser(
                        loginEmailController.text,
                        loginPasswordController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white)),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    final registerUsernameController = TextEditingController();
    int selectedRole = 2; // Default: User (2)

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Text("Create Your Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildTextField(
                controller: registerUsernameController,
                label: "Username",
                icon: Icons.person),
            const SizedBox(height: 10),
            _buildTextField(
                controller: registerEmailController,
                label: "Email Address",
                icon: Icons.email),
            const SizedBox(height: 10),
            _buildTextField(
                controller: registerPasswordController,
                label: "Password",
                icon: Icons.lock,
                isObscure: true),
            const SizedBox(height: 10),

            /// **Dropdown untuk memilih role**
            _buildRoleDropdown(
              selectedRole,
              (newValue) {
                selectedRole = newValue;
              },
            ),

            const SizedBox(height: 30),
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final username = registerUsernameController.text;
                        final email = registerEmailController.text;
                        final password = registerPasswordController.text;

                        bool success = await controller.registerUser(
                            username, email, password, selectedRole);

                        if (success) {
                          // Clear TextFields jika registrasi berhasil
                          registerUsernameController.clear();
                          registerEmailController.clear();
                          registerPasswordController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Register",
                          style: TextStyle(color: Colors.white)),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Widget Dropdown untuk memilih Role dalam Register
  Widget _buildRoleDropdown(int selectedRole, Function(int) onChanged) {
    return DropdownButtonFormField<int>(
      value: selectedRole,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.work, color: mainColor),
        labelText: "Select Role",
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      dropdownColor: Colors.white,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      icon: const Icon(Icons.arrow_drop_down, color: mainColor, size: 30),

      /// **Item dalam dropdown dengan desain lebih baik**
      items: [
        DropdownMenuItem(
          value: 0,
          child: Row(
            children: const [
              Text("Super Admin", style: TextStyle(fontSize: 16)),
              SizedBox(width: 10),
              Icon(Icons.supervisor_account, color: Colors.deepPurple),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 1,
          child: Row(
            children: const [
              Text("Admin", style: TextStyle(fontSize: 16)),
              SizedBox(width: 10),
              Icon(Icons.admin_panel_settings, color: Colors.redAccent),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 2,
          child: Row(
            children: const [
              Text("User", style: TextStyle(fontSize: 16)),
              SizedBox(width: 10),
              Icon(Icons.person, color: Colors.blueAccent),
            ],
          ),
        ),
      ],

      onChanged: (value) {
        onChanged(value!);
      },
    );
  }

  /// Widget untuk Input Field yang lebih bersih
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: mainColor),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
