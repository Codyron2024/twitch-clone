// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:twitch_clone/src/data/repository/auth/authentication_repository.dart'
    as _i5;
import 'package:twitch_clone/src/data/repository/golive/golive_repository.dart'
    as _i6;
import 'package:twitch_clone/src/data/repository/home/home_repository.dart'
    as _i4;
import 'package:twitch_clone/src/data/repository/livestream/livestream_repository.dart'
    as _i7;
import 'package:twitch_clone/src/data/storage_service.dart' as _i8;
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_cubit.dart'
    as _i12;
import 'package:twitch_clone/src/feature/bottomnavbar/cubit/bottomnavbar_cubit.dart'
    as _i3;
import 'package:twitch_clone/src/feature/broadcast/cubit/livestream_cubit.dart'
    as _i9;
import 'package:twitch_clone/src/feature/golive/cubit/golive_cubit.dart'
    as _i10;
import 'package:twitch_clone/src/feature/home/cubit/home_cubit.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.BottomnavbarCubit>(() => _i3.BottomnavbarCubit());
    gh.factory<_i4.Homerepository>(() => _i4.Homerepository());
    gh.factory<_i5.Authenticationrepository>(
        () => _i5.Authenticationrepository());
    gh.factory<_i6.GoliveRepository>(() => _i6.GoliveRepository());
    gh.factory<_i7.Livestreamrepository>(() => _i7.Livestreamrepository());
    gh.factory<_i8.Securestorage>(() => _i8.Securestorage());
    gh.factory<_i9.LivestreamCubit>(() =>
        _i9.LivestreamCubit(livestreamrepo: gh<_i7.Livestreamrepository>()));
    gh.factory<_i10.GoliveCubit>(
        () => _i10.GoliveCubit(goliverepo: gh<_i6.GoliveRepository>()));
    gh.factory<_i11.HomeCubit>(
        () => _i11.HomeCubit(homerepo: gh<_i4.Homerepository>()));
    gh.factory<_i12.AuthenticationCubit>(() => _i12.AuthenticationCubit(
          auth: gh<_i5.Authenticationrepository>(),
          securestorage: gh<_i8.Securestorage>(),
        ));
    return this;
  }
}
