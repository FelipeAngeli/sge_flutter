import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/masked_text_field.dart';
import '../cubit/users_cubit.dart';
import '../cubit/users_state.dart';
import '../models/user_model.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();
  final List<String> _selectedPermissions = [];

  @override
  void initState() {
    super.initState();
    final args = Modular.args.data;
    if (args != null && args['id'] != null) {
      BlocProvider.of<UsersCubit>(context).loadUser(args['id']);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuário'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.navigate('/users'),
        ),
      ),
      body: BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            _nameController.text = state.user.name;
            _emailController.text = state.user.email;
            _cpfController.text = state.user.cpf;
            _phoneController.text = state.user.phone;
            _selectedPermissions.clear();
            _selectedPermissions.addAll(state.user.permissions);
          }
          if (state is UsersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is UsersLoading;

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
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    label: 'E-mail',
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _cpfController,
                    label: 'CPF',
                    mask: '###.###.###-##',
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  MaskedTextField(
                    controller: _phoneController,
                    label: 'Celular',
                    mask: '(##) #####-####',
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Permissões',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: UserPermissions.all.map((permission) {
                      return FilterChip(
                        label: Text(permission.split('_').last),
                        selected: _selectedPermissions.contains(permission),
                        onSelected: !isLoading
                            ? (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedPermissions.add(permission);
                                  } else {
                                    _selectedPermissions.remove(permission);
                                  }
                                });
                              }
                            : null,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: isLoading ? 'Salvando...' : 'Salvar',
                    enabled: !isLoading,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final user = UserModel(
                          id: Modular.args.data?['id'] ?? '',
                          name: _nameController.text,
                          email: _emailController.text,
                          cpf: _cpfController.text,
                          phone: _phoneController.text,
                          permissions: _selectedPermissions,
                        );

                        if (user.id.isEmpty) {
                          BlocProvider.of<UsersCubit>(context).createUser(user);
                        } else {
                          BlocProvider.of<UsersCubit>(context).updateUser(user);
                        }
                      }
                    },
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
