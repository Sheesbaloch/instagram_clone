import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_Screen_Layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_Screen_Layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/custom_text_field.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(
      () {
        _isLoading = false;
      },
    );
    if (res != 'success') {
      showSnapBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayoutScreen(
            mobileScreenLayout: mobileScreenLayout(),
            webScreenLayout: webScreenLayout(),
          ),
        ),
      );
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //svg image
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "data:image/png;base64,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"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              //enter name
              CustomTextField(
                textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 32,
              ),
              //enter email
              CustomTextField(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 32,
              ),
              //enter password
              CustomTextField(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 32,
              ),
              //enter bio
              CustomTextField(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 32,
              ),
              //signup button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: const CircularProgressIndicator(),
                        )
                      : const Text('Sign up'),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //transational to login page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text(
                      'Already Register?',
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: blueColor, fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 9,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
