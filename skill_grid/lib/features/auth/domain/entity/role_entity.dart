class RoleEntity {
  static const client = RoleEntity._internal(1, "client");
  static const freelancer = RoleEntity._internal(2, "freelancer");

  final int roleId;
  final String name;

  const RoleEntity._internal(this.roleId, this.name);

  static List<RoleEntity> get roles => [client, freelancer];

  static RoleEntity? getByRoleId(int roleId) => roles.firstWhere((role) => role.roleId == roleId);

  static RoleEntity? getByName(String name) => roles.firstWhere((role) => role.name == name);
}
