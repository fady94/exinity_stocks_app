import 'package:exinity_app/core/resources/colors.dart';
import 'package:exinity_app/core/resources/images.dart';
import 'package:exinity_app/core/routing/app_routes.dart';
import 'package:exinity_app/core/services/websocket/bloc/websocket_bloc.dart';
import 'package:exinity_app/extensions/media_query.dart';
import 'package:exinity_app/features/app/presentation/cubit/app_cubit.dart';
import 'package:exinity_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppLoaded) {
          context.read<WebsocketBloc>().add(ConnectWebsocketEvent());
          context.pushReplacementNamed(AppRoutes.homeScreen.name);
        }
      },
      builder: (context, state) {
        if (state is AppInitial) {
          context.read<AppCubit>().init();
        }
        if (state is AppLoaded) {
          return const Scaffold(
            body: Center(
              child: Text('Loaded'),
            ),
          );
        } else if (state is AppFailed) {
          return Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: context.height / 5,
                ),
                Text(
                  "${state.failure.message}",
                  style: const TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<AppCubit>().init();
                    },
                    child: Text(S.of(context).retry)),
              ],
            ),
          ));
        } else {
          return Scaffold(
            backgroundColor: ColorManager.secondaryColor,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.logo,
                    height: 150,
                  ),
                  SizedBox(
                    height: context.height / 9,
                  ),
                  const CircularProgressIndicator(
                    color: ColorManager.primaryColor,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
