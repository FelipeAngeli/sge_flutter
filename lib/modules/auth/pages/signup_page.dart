import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/password_text_field.dart';
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
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          print('📱 Estado recebido na SignUpPage: $state');
          if (state is AuthSuccess) {
            print('✅ Navegando para /login');
            Modular.to.navigate('/login');
          } else if (state is AuthFailure) {
            print('❌ Erro: ${state.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    label: 'E-mail',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail é obrigatório';
                      }
                      if (!value.contains('@')) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _passwordController,
                    label: 'Senha',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Senha é obrigatória';
                      }
                      if (value.length < 6) {
                        return 'Senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirmar senha',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirmação de senha é obrigatória';
                      }
                      if (value != _passwordController.text) {
                        return 'As senhas não conferem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _cpfController,
                    label: 'CPF',
                    mask: '###.###.###-##',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CPF é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _phoneController,
                    label: 'Telefone',
                    mask: '(##) #####-####',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Telefone é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label:
                        state is AuthLoading ? 'Cadastrando...' : 'Cadastrar',
                    enabled: !(state is AuthLoading),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        BlocProvider.of<AuthCubit>(context).signUp(
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: _nameController.text,
                          cpf: _cpfController.text,
                          phone: _phoneController.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () => Modular.to.pushNamed('/login'),
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
