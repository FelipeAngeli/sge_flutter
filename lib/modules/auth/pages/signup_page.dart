import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/password_text_field.dart';
import '../../../shared/widgets/masked_text_field.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _cpfController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Modular.to.navigate('/home');
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final validationErrors =
              state is AuthValidationError ? state.errors : {};

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    controller: _nameController,
                    label: 'Nome completo',
                    errorText: validationErrors['name'],
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    label: 'E-mail',
                    errorText: validationErrors['email'],
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _passwordController,
                    label: 'Senha',
                    errorText: validationErrors['password'],
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirmar senha',
                    errorText: validationErrors['confirmPassword'],
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _cpfController,
                    label: 'CPF',
                    mask: '###.###.###-##',
                    errorText: validationErrors['cpf'],
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _phoneController,
                    label: 'Celular',
                    mask: '(##) #####-####',
                    errorText: validationErrors['phone'],
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: isLoading ? 'Cadastrando...' : 'Cadastrar',
                    enabled: !isLoading,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        BlocProvider.of<AuthCubit>(context).signUp(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
                          cpf: _cpfController.text,
                          phone: _phoneController.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed:
                        isLoading ? null : () => Modular.to.pushNamed('/login'),
                    child: const Text('Já tem conta? Faça login'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
