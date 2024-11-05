import 'package:flutter/material.dart';
import 'package:takemeals/services/auth_service.dart';
import 'package:takemeals/utils/constants.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final AuthService authService = AuthService();
  bool _isFetching = false;

  Future<void> _register() async {
    setState(() {
      _isFetching = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final name = _nameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords do not match"),
          ),
        );
        setState(() {
          _isFetching = false;
        });

        return;
      }

      await authService.register(context, name, email, phone, password);
    }

    setState(() {
      _isFetching = false;
    });
  }


  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: requiredValidator.call,
            onSaved: (value) {},
            textInputAction: TextInputAction.next,
            controller: _nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          const SizedBox(height: defaultPadding),

          TextFormField(
            validator: emailValidator.call,
            onSaved: (value) {},
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: const InputDecoration(hintText: "Email Address"),
          ),
          const SizedBox(height: defaultPadding),
          
          TextFormField(
            validator: phoneValidator.call,
            onSaved: (value) {},
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            decoration: const InputDecoration(hintText: "Phone Number"),
          ),
          const SizedBox(height: defaultPadding),

          TextFormField(
            obscureText: _obscureText,
            validator: passwordValidator.call,
            textInputAction: TextInputAction.next,
            onChanged: (value) {},
            onSaved: (value) {},
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: bodyTextColor)
                    : const Icon(Icons.visibility, color: bodyTextColor),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          TextFormField(
            obscureText: _obscureText,
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              hintText: "Confirm Password",
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: bodyTextColor)
                    : const Icon(Icons.visibility, color: bodyTextColor),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          // Register Button
          ElevatedButton(
            onPressed: _register,
            child: _isFetching
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text("Register"),
          ),
        ],
      ),
    );
  }
}
