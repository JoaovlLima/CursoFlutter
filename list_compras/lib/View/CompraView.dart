import 'package:flutter/material.dart';
import 'package:list_compras/Controller/CompraController.dart';
import 'package:provider/provider.dart';

class ListaTarefasScreen extends StatelessWidget {
  // Controlador para o campo de texto de nova tarefa
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      // Corpo principal do aplicativo
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Campo de texto para a descrição
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Campo de texto para a quantidade
                SizedBox(
                  width: 80,
                  child: TextField(
                    // Mesmo controlador para a quantidade
                    controller: _controller2,
                    decoration: InputDecoration(
                      labelText: 'Quantidade',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Chamando o método adicionarTarefa do Provider para atualizar o estado
                    Provider.of<ListaCompraControler>(context, listen: false)
                        .adicionarTarefa(
                            _controller.text,
                            int.parse(_controller2
                                .text) // Passando o mesmo texto para a quantidade por enquanto

                            );
                    // Ordenando a lista após adicionar uma nova tarefa
                    Provider.of<ListaCompraControler>(context, listen: false)
                        .ordenarTarefa();
                    // Limpar os campos de texto após adicionar a tarefa
                    _controller.clear();
                    _controller2.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),

          // Lista de tarefas usando um Consumer do Provider para atualização automática
          Expanded(
            child: Consumer<ListaCompraControler>(
              builder: (context, controller, child) {
                return ListView.builder(
                  itemCount: controller.compra.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Exibição do texto da tarefa
                          Text(controller.compra[index].descricao),
                          // Exibição da data da tarefa
                          Text(
                            'Quantidade: ${controller.compra[index].quantidade.toString()}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: controller.compra[index].comprada,
                        onChanged: (value) {
                          // Chamando o método marcarComoConcluida do Provider para atualizar o estado
                          controller.marcarComoConcluida(index);
                        },
                      ),
                      // Exclui a tarefa ao manter pressionado
                      onLongPress: () {
                        // Chamando o método excluirTarefa do Provider para atualizar o estado
                        controller.excluirTarefa(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
