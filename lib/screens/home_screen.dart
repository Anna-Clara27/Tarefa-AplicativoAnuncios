import 'package:flutter/material.dart';
import '../models/anuncio.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Anuncio> _anuncios = [
    Anuncio(
      titulo: 'Notebook Lenovo',
      descricao: 'Notebook com 8GB de RAM.',
      preco: 2499.90,
    ),
    Anuncio(
      titulo: 'iPhone 11',
      descricao: 'Celular com 64GB de armazenamento.',
      preco: 1399.90,
    ),
  ];

  Future<void> _cadastrarAnuncio() async {
    final anuncio = await Navigator.push<Anuncio>(
      context,
      MaterialPageRoute(builder: (context) => const CadastroScreen()),
    );

    if (anuncio != null) {
      setState(() {
        _anuncios.add(anuncio);
      });
    }
  }

  Future<void> _editarAnuncio(Anuncio anuncio) async {
    final anuncioEditado = await Navigator.push<Anuncio>(
      context,
      MaterialPageRoute(builder: (context) => CadastroScreen(anuncio: anuncio)),
    );

    if (anuncioEditado != null) {
      setState(() {
        final indice = _anuncios.indexOf(anuncio);
        _anuncios[indice] = anuncioEditado;
      });
    }
  }

  void _removerAnuncio(int indice) {
    final anuncio = _anuncios[indice];

    setState(() {
      _anuncios.removeAt(indice);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${anuncio.titulo} removido.'),
        action: SnackBarAction(
          label: 'DESFAZER',
          onPressed: () {
            setState(() {
              _anuncios.insert(indice, anuncio);
            });
          },
        ),
      ),
    );
  }

  String _formatarPreco(double preco) {
    return 'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black87,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.shopping_bag, color: Color(0xFF3483FA), size: 30),
            const SizedBox(width: 8),
            const Text(
              'mercado livre',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFFFE600),
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar produtos, marcas e muito mais...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _anuncios.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum anúncio cadastrado.',
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: _anuncios.length,
                    itemBuilder: (context, indice) {
                      final anuncio = _anuncios[indice];

                      return Dismissible(
                        key: ObjectKey(anuncio),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onDismissed: (_) {
                          _removerAnuncio(indice);
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          elevation: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5F0FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                color: Color(0xFF3483FA),
                                size: 38,
                              ),
                            ),
                            title: Text(
                              anuncio.titulo,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    anuncio.descricao,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _formatarPreco(anuncio.preco),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isThreeLine: true,
                            trailing: const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF3483FA),
                            ),
                            onTap: () => _editarAnuncio(anuncio),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3483FA),
        foregroundColor: Colors.white,
        onPressed: _cadastrarAnuncio,
        child: const Icon(Icons.add),
      ),
    );
  }
}
