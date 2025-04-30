import 'package:flutter/material.dart';

void main() {
  runApp(CadastroApp());
}

class CadastroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Usuário',
      home: Scaffold(
        appBar: AppBar(title: Text('Cadastro')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CadastroForm(),
        ),
      ),
    );
  }
}

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  bool _aceitaTermos = false;

  void _cadastrar() {
    // TODO: Implementar validação dos campos e exibir SnackBar com nome do usuário
    if (_formKey.currentState!.validate() && _aceitaTermos == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Realizado com Sucesso!')));
      NavegarParaTelaDeConfmacao();
    };
    if (_aceitaTermos == false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não é possível realizar o cadastro, pois é necessário aceitar os termos')));
    
    };
       if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não é possível realizar o cadastro, pois existem campos inválidos')));
    };
  }

  void _limparCampos() {
    // TODO: Limpar os campos e resetar o formulário

    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();
    _confirmaSenhaController.clear();
    _formKey.currentState!.reset();
    setState(() {
      _aceitaTermos = false;
    });
  }

  void NavegarParaTelaDeConfmacao() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TelaDeConfirmacao(name: _nomeController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome completo'),
            validator: (value) {
              // TODO: Validar nome (obrigatório e mínimo 3 caracteres)
              if(value == null || value.isEmpty){
                return 'O nome é um campo obrigatório';
              
              }
              if(value.length < 3){
                return 'O nome deve conter pelo menos 3 caracteres';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'E-mail'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              // TODO: Validar e-mail (obrigatório e formato válido)
              if (value == null || value.isEmpty) {
                return 'O e-mail é obrigatório';
              }
              if (!value.contains('@') || !value.contains(".")) {
                return 'Insira um e-mail de formato válido';
              }

              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _senhaController,
            decoration: InputDecoration(labelText: 'Senha'),
            obscureText: true,
            validator: (value) {
              // TODO: Validar senha (mínimo 6 caracteres, número, maiúscula)
              if (value == null || value.isEmpty) {
                return 'A senha é obrigatória';
              }
              if (value.length < 6 || value.toLowerCase() == value) {
                return 'A senha deve conter pelo menos 6 caracteres e ao menos 1 caractere maiúsculo';
              }

              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _confirmaSenhaController,
            decoration: InputDecoration(labelText: 'Confirmar senha'),
            obscureText: true,
            validator: (value) {
              // TODO: Validar se é igual à senha digitada acima
              if (value == null || value.isEmpty) {
                return 'Esse campo é obrigatório';
              }
              if (value != _senhaController.text) {
                return 'A senha deve ser igual nos dois campos';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          CheckboxListTile(
            title: Text('Aceito os termos de uso'),
            value: _aceitaTermos,
            onChanged: (value) {
              setState(() {
                _aceitaTermos = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _cadastrar,
                child: Text('Cadastrar'),
              ),
              OutlinedButton(
                onPressed: _limparCampos,
                child: Text('Limpar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TelaDeConfirmacao extends StatelessWidget {
  final String name;

  TelaDeConfirmacao({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Cadastro REalizado com sucesso!'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: Center(
          child: Text(
            'Seja bem vindo $name cadastro realizado com sucesso!',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ));
  }
}
