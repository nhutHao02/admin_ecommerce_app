import 'dart:convert';

import 'package:admin_ecommerce_app/models/user.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  var message = false;

  void signIn() async {
    setState(() => message = false);
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      if (await checkLogin()) {
        setState(() => isLoading = false);
        widget.onUserSignedIn(
            User(userId: '1', email: email, password: password));
      } else {
        setState(() {
          isLoading = false;
          message = true;
        });
        // tamthoi
        widget.onUserSignedIn(
            User(userId: '1', email: email, password: password));
      }
    }
  }

  Future<bool> checkLogin() async {
    print('checkLogin using');
    const url = 'http://tranhao123-001-site1.etempurl.com/admin/login-admin';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {"email": email.toString(), "password": password.toString()}));
    if (response.statusCode == 200) {
      print('checkLogin Success........');
      return true;
    } else {
      print('checkLogin failed with status: ${response.statusCode}.');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
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
            const Text('Đăng nhập',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => email = value,
                validator: (value) =>
                    value!.isEmpty ? 'Email không được để trống' : null),
            const SizedBox(height: 10),
            TextFormField(
                keyboardType: TextInputType.text,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
                obscureText: !isShowPassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: InkWell(
                    child: Icon(isShowPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onTap: () =>
                        setState(() => isShowPassword = !isShowPassword),
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => password = value,
                validator: (value) =>
                    value!.isEmpty ? 'Password không được để trống' : null),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  message
                      ? const Text(
                          'Sai email hoặc password',
                          style: TextStyle(color: Colors.red),
                        )
                      : const Text(''),
                ],
              ),
            ),
            isLoading
                ? const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()))
                : Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.blue),
                    child: MaterialButton(
                      onPressed: signIn,
                      child: const Text('Đăng nhập',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
