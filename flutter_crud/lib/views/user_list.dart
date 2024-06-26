import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.userForm);
              },
              icon: const Icon(Icons.add),
              color: Colors.green)
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => UserTile(user: users.byIndex(i)),
        itemCount: users.count,
      ),
    );
  }
}
