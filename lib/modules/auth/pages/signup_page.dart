import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
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

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _nameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;
  String? _cpfErrorText;
  String? _phoneErrorText;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateName);
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validateConfirmPassword);
    _cpfController.addListener(_validateCpf);
    _phoneController.addListener(_validatePhone);
  }

  void _validateName() {
    final name = _nameController.text.trim();
    setState(() {
      _nameErrorText = name.isEmpty ? 'Nome é obrigatório' : null;
    });
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _emailErrorText = 'E-mail é obrigatório';
      });
    } else {
      final authCubit = BlocProvider.of<AuthCubit>(context);
      if (!authCubit.isValidEmail(email)) {
        setState(() {
          _emailErrorText = 'E-mail inválido';
        });
      } else {
        setState(() {
          _emailErrorText = null;
        });
      }
    }
  }

  void _validatePassword() {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _passwordErrorText = 'Senha é obrigatória';
      });
    } else {
      final authCubit = BlocProvider.of<AuthCubit>(context);
      if (!authCubit.isValidPassword(password)) {
        setState(() {
          _passwordErrorText =
              'A senha deve ter ao menos 8 caracteres, 1 maiúscula, 1 minúscula e 1 número';
        });
      } else {
        setState(() {
          _passwordErrorText = null;
        });
      }
    }
    _validateConfirmPassword();
  }

  void _validateConfirmPassword() {
    final confirmPassword = _confirmPasswordController.text;
    final password = _passwordController.text;

    if (confirmPassword.isEmpty) {
      setState(() {
        _confirmPasswordErrorText = 'Confirmação de senha é obrigatória';
      });
    } else if (confirmPassword != password) {
      setState(() {
        _confirmPasswordErrorText = 'As senhas não conferem';
      });
    } else {
      setState(() {
        _confirmPasswordErrorText = null;
      });
    }
  }

  void _validateCpf() {
    final cpf = _cpfController.text.replaceAll(RegExp(r'\D'), '');
    if (cpf.length == 11) {
      final authCubit = BlocProvider.of<AuthCubit>(context);
      if (!authCubit.isValidCPF(_cpfController.text)) {
        setState(() {
          _cpfErrorText = 'CPF inválido';
        });
      } else {
        setState(() {
          _cpfErrorText = null;
        });
      }
    } else if (cpf.isNotEmpty) {
      setState(() {
        _cpfErrorText = 'CPF inválido';
      });
    } else {
      setState(() {
        _cpfErrorText = null;
      });
    }
  }

  void _validatePhone() {
    final phone = _phoneController.text.trim();
    setState(() {
      _phoneErrorText = phone.isEmpty ? 'Telefone é obrigatório' : null;
    });
  }

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

  void _updateErrorMessages(Map<String, String> errors) {
    setState(() {
      _nameErrorText = errors['name'];
      _emailErrorText = errors['email'];
      _passwordErrorText = errors['password'];
      _confirmPasswordErrorText = errors['confirmPassword'];
      _cpfErrorText = errors['cpf'];
      _phoneErrorText = errors['phone'];
    });
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
            // Atualiza as mensagens de erro baseado no estado
            final errors = <String, String>{};
            if (state.message.contains('Nome')) errors['name'] = state.message;
            if (state.message.contains('E-mail'))
              errors['email'] = state.message;
            if (state.message.contains('Senha'))
              errors['password'] = state.message;
            if (state.message.contains('Confirmação'))
              errors['confirmPassword'] = state.message;
            if (state.message.contains('CPF')) errors['cpf'] = state.message;
            if (state.message.contains('Telefone'))
              errors['phone'] = state.message;

            _updateErrorMessages(errors);
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
                    errorText: _nameErrorText,
                    validator: (value) => _nameErrorText,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    label: 'E-mail',
                    keyboardType: TextInputType.emailAddress,
                    errorText: _emailErrorText,
                    validator: (value) => _emailErrorText,
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _passwordController,
                    label: 'Senha',
                    errorText: _passwordErrorText,
                    validator: (value) => _passwordErrorText,
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirmar senha',
                    errorText: _confirmPasswordErrorText,
                    validator: (value) => _confirmPasswordErrorText,
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _cpfController,
                    label: 'CPF',
                    mask: '###.###.###-##',
                    keyboardType: TextInputType.number,
                    errorText: _cpfErrorText,
                    validator: (value) => _cpfErrorText,
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _phoneController,
                    label: 'Telefone',
                    mask: '(##) #####-####',
                    keyboardType: TextInputType.phone,
                    errorText: _phoneErrorText,
                    validator: (value) => _phoneErrorText,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: isLoading ? 'Cadastrando...' : 'Cadastrar',
                    enabled: !isLoading,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
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
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Erro ao realizar cadastro: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
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
