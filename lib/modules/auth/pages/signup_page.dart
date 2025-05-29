import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../utils/validation_messages.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../widgets/password_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/masked_text_field.dart';

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

  Map<String, ValidationErrorType> _errors = {};

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

  void _updateErrors(Map<String, ValidationErrorType> errors) {
    setState(() {
      _errors = errors;
    });
  }

  String? _getErrorMessage(String field) {
    return ValidationMessages.getFieldMessage(_errors, field);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Modular.to.navigate('/home');
          } else if (state is AuthValidationError) {
            _updateErrors(state.errors);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

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
                    errorText: _getErrorMessage('name'),
                    validator: (value) => _getErrorMessage('name'),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    label: 'E-mail',
                    keyboardType: TextInputType.emailAddress,
                    errorText: _getErrorMessage('email'),
                    validator: (value) => _getErrorMessage('email'),
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _passwordController,
                    label: 'Senha',
                    errorText: _getErrorMessage('password'),
                    validator: (value) => _getErrorMessage('password'),
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirmar senha',
                    errorText: _getErrorMessage('confirmPassword'),
                    validator: (value) => _getErrorMessage('confirmPassword'),
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _cpfController,
                    label: 'CPF',
                    mask: '###.###.###-##',
                    keyboardType: TextInputType.number,
                    errorText: _getErrorMessage('cpf'),
                    validator: (value) => _getErrorMessage('cpf'),
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _phoneController,
                    label: 'Telefone',
                    mask: '(##) #####-####',
                    keyboardType: TextInputType.phone,
                    errorText: _getErrorMessage('phone'),
                    validator: (value) => _getErrorMessage('phone'),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: isLoading ? 'Cadastrando...' : 'Cadastrar',
                    enabled: !isLoading,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final context = this.context;
                        try {
                          await BlocProvider.of<AuthCubit>(context).signUp(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            confirmPassword:
                                _confirmPasswordController.text.trim(),
                            name: _nameController.text.trim(),
                            cpf: _cpfController.text.trim(),
                            phone: _phoneController.text.trim(),
                          );
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Erro ao realizar cadastro: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
