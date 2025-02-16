import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String errorMessage = ""; // Lưu thông báo lỗi

  bool isLogin = true; // Biến để xác định chế độ đăng nhập hay đăng ký

  // Kiểm tra email hợp lệ
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  // Kiểm tra mật khẩu hợp lệ (ít nhất 6 ký tự)
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  void _submit() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Kiểm tra email hợp lệ
    if (email.isEmpty || !_isValidEmail(email)) {
      setState(() {
        errorMessage = "Email chưa hợp lệ.";
      });
      return;
    }

    // Kiểm tra mật khẩu hợp lệ
    if (password.isEmpty || !_isValidPassword(password)) {
      setState(() {
        errorMessage = "Mật khẩu phải hơn 6 kí tự";
      });
      return;
    }

    try {
      if (isLogin) {
        // Đăng nhập
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        // Đăng ký
        if (passwordController.text != confirmPasswordController.text) {
          setState(() {
            errorMessage = "Mật khẩu không khớp!";
          });
          return;
        } else {
          await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          // Chuyển về chế độ đăng nhập sau khi đăng ký thành công
          setState(() {
            isLogin = true; // Đặt lại trạng thái là đăng nhập
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Đăng ký thành công!")),
          );
          return;
        }
      }
      // Chuyển hướng đến trang Home nếu thành công
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>
            ProductManagementScreen()), // Sử dụng Home từ Home.dart
      );
    } catch (e) {
      // Hiển thị thông báo lỗi
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Đăng Nhập" : "Đăng Ký"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Ảnh logo
                Image(
                  height: 200,
                  image: AssetImage('img/logos.png'), // Đường dẫn đến ảnh logo
                ),
                SizedBox(height: 20),
                // Tên ứng dụng
                Text(
                  "Welcome to MyApp",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 30),
                // Email TextField
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                // Mật khẩu TextField
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Mật Khẩu",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                if (!isLogin) ...[
                  SizedBox(height: 10),
                  // Nhập lại mật khẩu TextField khi đăng ký
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: TextField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: "Nhập lại Mật Khẩu",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
                SizedBox(height: 20),
                // Submit Button
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(isLogin ? "Đăng Nhập" : "Đăng Ký"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin; // Chuyển giữa đăng nhập và đăng ký
                    });
                  },
                  child: Text(
                    isLogin ? "Chưa có tài khoản? Đăng ký" : "Đã có tài khoản? Đăng nhập",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                // Hiển thị thông báo lỗi nếu có
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}