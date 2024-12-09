import 'package:conectar_api/models/PedidoModel.dart';

class ClienteModel {
  final String id;
  final String nome;
  final String cpf;
  final String telefone;
  final String endereco;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.endereco,
  });

  ClienteModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        nome = json['nome'] ?? '',
        cpf = json['cpf'] ?? '',
        telefone = json['telefone'] ?? '',
        endereco = json['endereco'] ?? '';
}
