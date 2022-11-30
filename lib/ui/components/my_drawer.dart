import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
           UserAccountsDrawerHeader(accountEmail: const Text('marilene@gmail.com'),
            accountName: const Text('Marilene'), 
            currentAccountPicture: ClipOval(child: Image.asset('lib/style/assets/img/userprofile.png', width: 20, height: 20,)),
            decoration: const BoxDecoration(
              
                  color:Color.fromARGB(255, 35, 35, 35)),
            ),
          ListTile(
            tileColor: const Color(0xFF454545),
            leading: const Icon(Icons.home, color: Colors.white,),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            tileColor: const Color(0xFF454545),
            leading: const Icon(Icons.graphic_eq, color: Colors.white,),
            title: const Text('Relatório', style: TextStyle(color: Colors.white)),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          
          ListTile(
            tileColor: const Color(0xFF454545),
            leading: const Icon(Icons.drive_folder_upload_rounded,color: Colors.white),
            title: const Text('Categorias',style: TextStyle(color: Colors.white)),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            tileColor: const Color(0xFF454545),
            leading: const Icon(Icons.mail,color: Colors.white),
            title: const Text('Fale conosco',style: TextStyle(color: Colors.white)),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            tileColor: const Color(0xFF454545),
            title: const Text('Ativar modo Dark',style: TextStyle(color: Colors.white)),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            tileColor: const Color(0xFF454545),
            leading: const Icon(Icons.logout,color: Colors.white),
            title: const Text('Sair',style: TextStyle(color: Colors.white)),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          Container(
            color: const Color(0xFF454545),
            height: 500,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
          ),          
        ],
      ),
    );
  }
}