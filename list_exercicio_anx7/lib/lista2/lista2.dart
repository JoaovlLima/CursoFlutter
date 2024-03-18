import 'package:flutter/material.dart';
import 'exIndicador.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListViewWidget(),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  final List<Widget> itens = [
    Card(
      child: ListTile(
        title: Text("Card 1"),
        subtitle: Text('Descrição do card 1'),
        leading: Icon(Icons.android),
      ),
    ),
    Card(
      child: ListTile(
        title: Text("Card 2"),
        subtitle: Text('Descrição do card 2'),
        leading: Icon(Icons.abc_outlined),
      ),
    ),
    Card(
      child: ListTile(
        title: Text("Card 3"),
        subtitle: Text('Descrição do card 3'),
        leading: Icon(Icons.backpack),
      ),
    ),
   Padding(
  padding: EdgeInsets.only(top: 8.0),
  child: ElevatedButton.icon(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blue), // Define a cor de fundo do botão
      minimumSize: MaterialStateProperty.all(Size(200, 60)), // Define o tamanho mínimo do botão
    ),
    icon: Icon(Icons.add, color: Colors.white), // Ícone do botão
    label: Text('Adicionar', style: TextStyle(color: Colors.white)), // Texto do botão
  ),
),
TextButton.icon(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.green), // Define a cor de fundo do botão
      minimumSize: MaterialStateProperty.all(Size(160, 50)), // Define o tamanho mínimo do botão
    ),
    icon: Icon(Icons.remove, color: Colors.white), // Ícone do botão
    label: Text('Remover', style: TextStyle(color: Colors.white)), // Texto do botão
  ),

OutlinedButton.icon(
    onPressed: () {},
    style: ButtonStyle(
      side: MaterialStateProperty.all(BorderSide(color: Colors.red)), // Define a cor da borda do botão
      minimumSize: MaterialStateProperty.all(Size(120, 40)), // Define o tamanho mínimo do botão
    ),
    icon: Icon(Icons.search, color: Colors.red), // Ícone do botão
    label: Text('Buscar', style: TextStyle(color: Colors.red)), // Texto do botão
  ),

    // Adicione mais Cards conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Layout com Abas e com lista dinâmica'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Aba 1'),
              onTap: () {
                DefaultTabController.of(context)?.animateTo(0);
                Navigator.pop(context); // Fechar o drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Aba 2'),
              onTap: () {
                 
                 Navigator.pop(context);
                  // Fechar o drawer
              },
            ),
             ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Aba 3'),
              onTap: () {
                
                 Navigator.pop(context); // Fechar o drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Aba 4'),
              onTap: () {
                  
                 Navigator.pop(context); // Fechar o drawer
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(text: 'Aba 1'),
              Tab(text: 'Aba 2'),
              Tab(text: 'Aba 3'),
              Tab(text: 'aba 4')
            ],
          ),
          body: TabBarView(
            children: [
              ListView(
                children: itens,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.05),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Nome'),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      TextField(
                        decoration: InputDecoration(labelText: 'E-mail'),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      TextField(
                        decoration: InputDecoration(labelText: 'Senha'),
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      ElevatedButton(
                        onPressed: () {
                          // Lógica do botão
                        },
                        child: Text("Cadastrar"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 245, 242, 238),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        'https://53097.cdn.simplo7.net/static/53097/sku/placas-placas-de-sinalizacao-de-transito-placa-de-sinalizacao-regularizacao-estacionamento-regulamentado--p-1615483330906.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://isinaliza.vtexassets.com/arquivos/ids/163229-800-auto?v=636704522725670000&width=800&height=auto&aspect=true',
                        width: 200,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
           ProgressIndicatorExample(),
            ],
          ),
        ),
      ),
    );
  }
}
