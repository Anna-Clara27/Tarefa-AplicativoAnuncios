import 'package:flutter/material.dart';
import '../models/anuncio.dart';

class CadastroScreen extends StatefulWidget {
  final Anuncio? anuncio;

  const CadastroScreen({super.key, this.anuncio});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();

  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();

  bool get _editando => widget.anuncio != null;

  @override
  void initState() {
    super.initState();

    if (widget.anuncio != null) {
      _tituloController.text = widget.anuncio!.titulo;
      _descricaoController.text = widget.anuncio!.descricao;
      _precoController.text = widget.anuncio!.preco
          .toStringAsFixed(2)
          .replaceAll('.', ',');
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final preco = double.parse(
        _precoController.text.trim().replaceAll(',', '.'),
      );

      final anuncio = Anuncio(
        titulo: _tituloController.text.trim(),
        descricao: _descricaoController.text.trim(),
        preco: preco,
      );

      Navigator.pop(context, anuncio);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black87,
        title: Text(
          _editando ? 'Editar Anúncio' : 'Novo Anúncio',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Dados do anúncio',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Ex.: Notebook Lenovo',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Informe o título.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descricaoController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Descreva o produto ou serviço...',
                prefixIcon: Icon(Icons.description_outlined),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Informe a descrição.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _precoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Preço',
                hintText: 'Ex.: 1299,90',
                prefixText: 'R\$ ',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Informe o preço.';
                }

                final preco = double.tryParse(
                  valor.trim().replaceAll(',', '.'),
                );

                if (preco == null || preco <= 0) {
                  return 'Informe um preço válido.';
                }

                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _salvar,
                icon: Icon(_editando ? Icons.save : Icons.add),
                label: Text(
                  _editando ? 'Salvar alterações' : 'Cadastrar anúncio',
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3483FA),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
