import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:burkut_mchs/main/logic/main_cubit.dart';
import 'package:burkut_mchs/main/view/add_information.dart';
import 'package:burkut_mchs/main/view/sos_message.dart';

class MchsMainView extends StatefulWidget {
  const MchsMainView({super.key});
  static Page<void> page() => const MaterialPage<void>(child: MchsMainView());
  @override
  State<MchsMainView> createState() => _MchsMainViewState();
}

class _MchsMainViewState extends State<MchsMainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (_) => MainCubit(),
        ),
      ],
      child: const MainScreen([
        SosMessage(),
        AddInformationsPage(),
      ]),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen(this.items, {super.key});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[context.watch<MainCubit>().state],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: context.read<MainCubit>().change,
        selectedIndex: context.watch<MainCubit>().state,
        indicatorShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Ыкчам кабар',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Маалымат кошуу',
          ),
        ],
      ),
    );
  }
}
