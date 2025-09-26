import 'package:get_it/get_it.dart';
import 'package:imove_challenge/features/authentication/repositories/abstract_authentication_repository.dart';

import 'package:imove_challenge/features/authentication/bloc/authentication_bloc.dart';

extension AuthenticationBlocDiExtensions on GetIt {
  GetIt registerAuthenticationBloc() {
    registerFactory<AuthenticationBloc>(
      () => AuthenticationBloc(authenticationRepository: get<IAuthenticationRepository>()),
    );
    return this;
  }

  AuthenticationBloc get authenticationBloc => get<AuthenticationBloc>();
}
