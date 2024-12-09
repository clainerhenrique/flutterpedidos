import 'dart:convert';
import 'package:conectar_api/models/PedidoModel.dart';
import 'package:http/http.dart' as http;

class PedidoService {
  dynamic _response;

  String url = "http://localhost:8080/pedidos/salvar";

  Future<dynamic> salvaProduto(PedidoModel pedido) async {
    _response = await http.post(Uri.parse(url),
        body: json.encode(pedido.toJson()),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    if (_response.statusCode == 200 || _response.statusCode == 201) {
      return PedidoModel.fromJson(json.decode(_response.body)); // Retorna o pedido salvo
    } else {
      return false; // Retorna falso se não conseguir salvar
    }
  }

  Future<List<PedidoModel>> listarPedidos() async {
    try {
      _response = await http.get(
        Uri.parse("http://localhost:8080/clientes/listar"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );

      if (_response.statusCode == 200) {
        // Decodifica a resposta para obter os clientes com seus pedidos
        List<dynamic> jsonListClientes = json.decode(utf8.decode(_response.bodyBytes));

        // Extraímos os pedidos de cada cliente
        List<PedidoModel> pedidos = [];
        for (var cliente in jsonListClientes) {
          if (cliente['pedidos'] != null) {
            for (var pedido in cliente['pedidos']) {
              pedidos.add(PedidoModel.fromJson(pedido)); // Mapeia os pedidos
            }
          }
        }
        return pedidos;
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao listar pedidos: $e');
      return [];
    }
  }

  // Função para editar um pedido
  Future<dynamic> editarPedido(String id, PedidoModel pedido) async {
    final url = "http://localhost:8080/pedidos/editar/$id"; // Rota para editar pedido

    _response = await http.put(Uri.parse(url),
        body: json.encode(pedido.toJson()), // Passa o pedido atualizado no corpo da requisição
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    if (_response.statusCode == 200) {
      return PedidoModel.fromJson(json.decode(_response.body)); // Retorna o pedido editado
    } else {
      return false; // Retorna falso se não conseguir editar
    }
  }

  // Função para deletar um pedido
  Future<bool> deletarPedido(String id) async {
    final url = "http://localhost:8080/pedidos/deletar/$id"; // Rota para deletar pedido

    _response = await http.delete(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    if (_response.statusCode == 200) {
      return true; // Pedido deletado com sucesso
    } else {
      return false; // Retorna falso se não conseguir deletar
    }
  }


}
