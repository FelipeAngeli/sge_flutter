import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/widgets/email_field.dart';
import '../../shared/widgets/login_button.dart';
import '../../shared/widgets/password_field.dart';
import 'login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'teste@teste.com');
  final _senhaController = TextEditingController(text: '123456');

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Modular.to.navigate('/home');
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 100,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Bem-vindo ao SGE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Faça login para continuar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    EmailField(controller: _emailController),
                    const SizedBox(height: 16),
                    PasswordField(controller: _senhaController),
                    const SizedBox(height: 24),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return LoginButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Modular.get<LoginCubit>().login(
                                _emailController.text,
                                _senhaController.text,
                              );
                            }
                          },
                          isLoading: state is LoginLoading,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
