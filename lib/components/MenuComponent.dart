import 'package:conectar_api/screens/CadastroclienteScreen.dart';
import 'package:conectar_api/screens/ListScreen.dart';
import 'package:conectar_api/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MenuComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Cadastra Produto'),
              onTap: () {
                // Handle item 1 tap
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      HomeScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Lista pedidos'),
              onTap: () {
                // Handle item 1 tap
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ListScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Cadastrar Clientes'),
              onTap: () {
                // Handle item 1 tap
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      CadastroClienteScreen()),
                );
              },
            ),
          ],
        ),
      );
  }
}