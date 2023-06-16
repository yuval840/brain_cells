class signInWithEmailAndPasswordFailure {
  final String message;

  const signInWithEmailAndPasswordFailure(
      [this.message = "An Unknown error occured."]);

  factory signInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-Name':
        return const signInWithEmailAndPasswordFailure(
            'please enter your First Name');
      case 'invalid-Last-Name':
        return const signInWithEmailAndPasswordFailure(
            'please enter your Last Name');
      case 'wrong-password':
        return const signInWithEmailAndPasswordFailure(
            'your password is incorrect');
      case 'user-not-found':
        return const signInWithEmailAndPasswordFailure(
            'The Email you enter not exist plese sign in first');
      case 'weak-password':
        return const signInWithEmailAndPasswordFailure(
            'The given password is invalid. [ Password should be at least 6 characters ]');
      case 'invalid - email':
        return const signInWithEmailAndPasswordFailure('email is not valid');
      case 'email-already-in-use':
        return const signInWithEmailAndPasswordFailure(
            'an account already exists for that email');
      default:
        return const signInWithEmailAndPasswordFailure();
    }
  }
}
