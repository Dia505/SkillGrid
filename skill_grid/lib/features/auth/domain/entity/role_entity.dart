class RoleEntity {
  static const client = RoleEntity._internal(1, "client");
  static const freelancer = RoleEntity._internal(2, "freelancer");

  final int id;
  final String name;

  const RoleEntity._internal(this.id, this.name);

  static List<RoleEntity> get roles => [client, freelancer];

  static RoleEntity? getById(int id) => roles.firstWhere((role) => role.id == id);

  static RoleEntity? getByName(String name) => roles.firstWhere((role) => role.name == name);
}
