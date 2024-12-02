enum Validated {
  valid,
  invalid,
  empty,
  short,
}

Validated isEmailValid(String? email){
  final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  if(email == null || email.isEmpty){
    return Validated.empty;
  } else if (!emailRegExp.hasMatch(email.trim())){
    return Validated.invalid;
  } else{
    return Validated.valid;
  }
}

Validated isPasswordValid(String? password){
  if(password == null || password.isEmpty){
    return Validated.empty;
  } else if (password.length < 6){
    return Validated.short;
  } else{
    return Validated.valid;
  }
}