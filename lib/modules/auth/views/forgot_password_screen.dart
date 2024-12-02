import 'package:flutter/material.dart';
import 'package:flutter_wallet/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_wallet/shared/widgets/custom_text_field.dart';
import 'package:flutter_wallet/shared/widgets/gradient_button.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetWidget<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RxBool _isEmailSent = false.obs;
  ForgotPasswordScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4a4a4a)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4a4a4a),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email to receive password reset instructions',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF717171),
                  ),
                ),
                const SizedBox(height: 32),

                // Email Field
                Obx(() => !_isEmailSent.value
                    ? CustomTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      )
                    : Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF94BBE9).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Color(0xFF94BBE9),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Password reset instructions have been sent to your email',
                                style: TextStyle(
                                  color: Color(0xFF4a4a4a),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                const SizedBox(height: 32),

                // Submit Button
                Obx(() => !_isEmailSent.value
                    ? GradientButton(
                        text: 'Send Instructions',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Implement password reset logic
                            _isEmailSent.value = true;
                          }
                        },
                      )
                    : GradientButton(
                        text: 'Back to Login',
                        onPressed: () => Get.back(),
                      )),

                const SizedBox(height: 24),

                // Additional Instructions
                Obx(() => !_isEmailSent.value
                    ? Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF94BBE9).withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Note:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4a4a4a),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '- Please check your spam folder if you don\'t see the email\n'
                              '- The reset link will expire in 1 hour\n'
                              '- Make sure to use the email associated with your account',
                              style: TextStyle(
                                color: Color(0xFF717171),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
