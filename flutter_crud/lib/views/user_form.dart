import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final Map<String, String> _formData = {};

  final _form = GlobalKey<FormState>();

  void loadFormData(user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Object? user = ModalRoute.of(context)?.settings.arguments;

    loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulário de Usuário',
        ),
        actions: [
          IconButton(
              onPressed: () {
                final formState = _form.currentState;

                if (formState != null) {
                  final isValid = formState.validate();
                  if (isValid) {
                    formState.save();

                    Provider.of<Users>(context, listen: false).put(
                      User(
                        id: _formData['id'],
                        name: _formData['name']!,
                        email: _formData['email']!,
                        avatarUrl: _formData['avatarUrl']!,
                      ),
                    );

                    Navigator.of(context).pop();
                  }
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nome inválido";
                  }
                  if (value.trim().length < 3) {
                    return "Ocorreu um erro";
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: const InputDecoration(labelText: 'Url do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
