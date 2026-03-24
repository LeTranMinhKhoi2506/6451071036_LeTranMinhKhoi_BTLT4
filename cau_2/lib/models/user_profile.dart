class UserProfile {
  String name;
  int age;
  String gender;
  String maritalStatus;
  double income;

  UserProfile({
    this.name = '',
    this.age = 0,
    this.gender = '',
    this.maritalStatus = 'Độc thân',
    this.income = 15.0,
  });

  @override
  String toString() {
    return 'Name: $name, Age: $age, Gender: $gender, Marital Status: $maritalStatus, Income: $income tr VND';
  }
}
