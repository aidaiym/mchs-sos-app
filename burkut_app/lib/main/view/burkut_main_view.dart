import 'package:burkut_app/main/logic/main_cubit.dart';
import 'package:burkut_app/main/view/news_list.dart';
import 'package:burkut_app/main/view/sos_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BurkutMainView extends StatefulWidget {
  const BurkutMainView({super.key});
  static Page<void> page() => const MaterialPage<void>(child: BurkutMainView());
  @override
  State<BurkutMainView> createState() => _BurkutMainViewState();
}

class _BurkutMainViewState extends State<BurkutMainView> {
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
        NewsListView(),
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
            icon: Icon(Icons.newspaper),
            label: 'Маалыматтар',
          ),
        ],
      ),
    );
  }
}
