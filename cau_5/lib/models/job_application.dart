class JobApplication {
  String fullName;
  String email;
  String? cvFileName;
  bool isConfirmed;

  JobApplication({
    this.fullName = '',
    this.email = '',
    this.cvFileName,
    this.isConfirmed = false,
  });

  @override
  String toString() {
    return 'JobApplication(fullName: $fullName, email: $email, cvFileName: $cvFileName, isConfirmed: $isConfirmed)';
  }
}
