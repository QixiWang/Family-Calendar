import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const bgColor = Color(0xFFFFFBF5);
  static const primaryColor = Color(0xFF0F172A);
  static const accentColor = Color(0xFFFAC638);
  static const secondaryAccent = Color(0xFFF59E0B);
  static const labelColor = Color(0xFF1E293B);
  static const hintColor = Color(0xFF64748B);
  static const placeholderColor = Color(0xFF94A3B8);
  static const borderColor = Color(0xFFE2E8F0);
  static const fieldBackgroundColor = Color(0xFFFFF6EA);
  static const fieldBorderColor = Color(0xFFDDE2E7);

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildLogoHeader(),
                    const SizedBox(height: 24),
                    _buildRegisterCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                accentColor.withOpacity(0.22),
                Colors.white.withOpacity(0.0),
              ],
              radius: 0.8,
            ),
            border: Border.all(
              color: accentColor.withOpacity(0.2),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.location_on,
              size: 42,
              color: accentColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Cottage',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColor,
            letterSpacing: -0.75,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your family\'s shared space',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF7E7664),
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFullNameField(),
            const SizedBox(height: 18),
            _buildEmailField(),
            const SizedBox(height: 18),
            _buildPasswordField(),
            const SizedBox(height: 28),
            _buildCreateAccountButton(),
            const SizedBox(height: 24),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildFullNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Full Name',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: labelColor,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: fieldBackgroundColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: fieldBorderColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                hintText: 'Enter your full name',
                hintStyle: const TextStyle(
                  color: placeholderColor,
                  fontSize: 16,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email Address',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: labelColor,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: fieldBackgroundColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: fieldBorderColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'name@example.com',
                hintStyle: const TextStyle(
                  color: placeholderColor,
                  fontSize: 16,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: labelColor,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: fieldBackgroundColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: fieldBorderColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Create a secure password',
                hintStyle: const TextStyle(
                  color: placeholderColor,
                  fontSize: 16,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [accentColor, secondaryAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle account creation
            print('Full Name: ${fullNameController.text}');
            print('Email: ${emailController.text}');
            print('Password: ${passwordController.text}');
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Text(
              'Create Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: hintColor,
            fontFamily: 'Plus Jakarta Sans',
          ),
          children: [
            const TextSpan(text: 'Already have an account? '),
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: secondaryAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
