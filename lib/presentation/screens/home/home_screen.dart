import 'package:adopme_frontend/presentation/screens/pet/pet_selection/pet_selection_screen.dart';
import 'package:adopme_frontend/presentation/screens/profile/profile_screen.dart';
import 'package:adopme_frontend/presentation/screens/vet/vet_list/vet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:adopme_frontend/presentation/screens/pet/pet_list/pet_list_screen.dart';
import 'package:adopme_frontend/presentation/screens/pet/register_pet/register_pet_screen.dart';
import 'package:adopme_frontend/presentation/screens/feed/feed_screen.dart';
import '../../widgets/bottom_sheet/bottom_sheet_options.dart';
import '../other_page.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../pet/report_missing_pet/report_missing_pet_screen.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  static final List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    PetSelectionScreen(),
    RegisterPetScreen(),
    VetScreen(),
    ProfileScreen(),
  ];

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(controller.selectedIndex),
            ),
            bottomNavigationBar: BottomNavBar(
              selectedIndex: controller.selectedIndex,
              onItemTapped: controller.onItemTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Buscar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle, size: 40),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_hospital_rounded),
                  label: 'Veterinarias',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
              onAddButtonPressed: () => showOptions(context, <ListTile>[
                ListTile(
                  leading: Icon(Icons.pets),
                  title: Text('Register Pet'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPetScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.report),
                  title: Text('Report Missing Pet'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReportMissingPetScreen()),
                    );
                  },
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
