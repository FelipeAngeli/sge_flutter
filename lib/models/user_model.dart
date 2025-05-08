class UserModel {
  final String id;
  final String name;
  final String email;
  final String cpf;
  final String phone;
  final List<String> permissions;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.phone,
    required this.permissions,
    this.isActive = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      cpf: json['cpf'] as String,
      phone: json['phone'] as String,
      permissions: List<String>.from(json['permissions'] as List),
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cpf': cpf,
      'phone': phone,
      'permissions': permissions,
      'is_active': isActive,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? cpf,
    String? phone,
    List<String>? permissions,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      phone: phone ?? this.phone,
      permissions: permissions ?? this.permissions,
      isActive: isActive ?? this.isActive,
    );
  }
}

class UserPermissions {
  static const String viewProducts = 'view_products';
  static const String createProducts = 'create_products';
  static const String editProducts = 'edit_products';
  static const String deleteProducts = 'delete_products';

  static const String viewReports = 'view_reports';
  static const String generateReports = 'generate_reports';

  static const String viewUsers = 'view_users';
  static const String createUsers = 'create_users';
  static const String editUsers = 'edit_users';
  static const String deleteUsers = 'delete_users';

  static const String viewSettings = 'view_settings';
  static const String editSettings = 'edit_settings';

  static List<String> get all => [
        viewProducts,
        createProducts,
        editProducts,
        deleteProducts,
        viewReports,
        generateReports,
        viewUsers,
        createUsers,
        editUsers,
        deleteUsers,
        viewSettings,
        editSettings,
      ];

  static List<String> get admin => all;

  static List<String> get manager => [
        viewProducts,
        createProducts,
        editProducts,
        viewReports,
        generateReports,
        viewUsers,
        viewSettings,
      ];

  static List<String> get operator => [
        viewProducts,
        viewReports,
      ];
}
