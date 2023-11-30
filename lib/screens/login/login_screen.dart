import 'package:admin_ecommerce_app/models/user.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this.onUserSignedIn, {super.key});

  final void Function(User?) onUserSignedIn;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';

  var isLoading = false;
  var isShowPassword = false;

  void signIn() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() => isLoading = false);
      widget.onUserSignedIn(User(userId: '1111', email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign In', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => email = value,
                validator: (value) => value!.isEmpty ? 'Email must not be empty' : null),
            const SizedBox(height: 10),
            TextFormField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                obscureText: !isShowPassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: InkWell(
                    child: Icon(isShowPassword ? Icons.visibility : Icons.visibility_off),
                    onTap: () => setState(() => isShowPassword = !isShowPassword),
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => password = value,
                validator: (value) => value!.isEmpty ? 'Password must not be empty' : null),
            const SizedBox(height: 30),
            isLoading
                ? const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()))
                : Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.blue),
                    child: MaterialButton(
                      onPressed: signIn,
                      child: const Text('Sign In', style: TextStyle(color: Colors.white)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
