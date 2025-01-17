enum UserRole { client, freelancer, none }

class JoinAsClientFreelancerState {
  final UserRole selectedRole;
  JoinAsClientFreelancerState({this.selectedRole = UserRole.none});
}