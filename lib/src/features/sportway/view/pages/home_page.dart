import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportway/src/features/sportway/logic/cubit/bottom_bar_selector/bottom_bar_selector_cubit.dart';
import 'package:sportway/src/features/sportway/view/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static Route go() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Widget> pages = [
    DiscoverPage(),
    BuddiesPage(),
    const UserAccountPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    //
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    context.select((BottomBarSelectorCubit cubit) => cubit.state);
    final bottomBarCubit = context.read<BottomBarSelectorCubit>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              bottomBarCubit.setBar(HomeBottomBar.discover);
              break;
            case 1:
              bottomBarCubit.setBar(HomeBottomBar.buddies);
              break;
            case 2:
              bottomBarCubit.setBar(HomeBottomBar.userAccount);
              break;
            case 3:
              bottomBarCubit.setBar(HomeBottomBar.settings);
              break;
            default:
          }
        },
        selectedLabelStyle:
            textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300),
        showUnselectedLabels: true,
        useLegacyColorScheme: false,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'Discover',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Buddies',
            icon: Icon(Icons.shopping_basket),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: bottomBarCubit.state.bottomBars.index,
      ),
      body: pages[bottomBarCubit.state.bottomBars.index],
    );
  }
}
