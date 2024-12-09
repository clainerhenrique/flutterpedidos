import 'dart:convert';

import 'package:get/get.dart';
import '../models/PedidoModel.dart';
import '../services/pedidoService.dart';
import 'clienteController.dart';

class PedidoController extends GetxController {
  PedidoService _pedidoService = PedidoService();

  var isLoading = false.obs; // Estado de carregamento
  var pedido = <PedidoModel>[].obs; // Lista de pedidos

  static PedidoController get pedidoController => Get.find();

  get http => null;

  // Método para listar pedidos
  Future<void> listarPedidos() async {
    isLoading.value = true; // Indica que está carregando
    try {
      var lista = await _pedidoService.listarPedidos();
      if (lista.isNotEmpty) {
        pedido.assignAll(lista); // Atualiza a lista de pedidos
      } else {
        pedido.clear(); // Limpa a lista se estiver vazia
      }
    } catch (e) {
      pedido.clear(); // Limpa a lista em caso de erro
      print('Erro ao listar pedidos: $e');
    } finally {
      isLoading.value = false; // Finaliza o carregamento
    }
  }

  // Método para salvar um pedido
  Future<bool> salvar(PedidoModel pedidoModel) async {
    isLoading.value = true; // Inicia o carregamento
    try {
      var resposta = await _pedidoService.salvaProduto(pedidoModel);
      if (resposta != null) {
        pedido.add(resposta); // Adiciona o pedido salvo na lista
        return true; // Retorna verdadeiro se o pedido foi salvo com sucesso
      }
      return false; // Retorna falso se não conseguir salvar
    } catch (e) {
      print('Erro ao salvar pedido: $e'); // Mensagem de erro
      return false; // Retorna falso em caso de erro
    } finally {
      isLoading.value = false; // Finaliza o carregamento
    }
  }

  // Método para obter o nome do cliente vinculado ao pedido
  String? obterNomeCliente(String clienteId) {
    final clienteController = ClienteController.clienteController;
    final cliente = clienteController.obterClientePorId(clienteId);
    return cliente?.nome;
  }

  // Método para editar um pedido
  // Método para atualizar um pedido
  Future<void> atualizarPedido(PedidoModel pedido) async {
    isLoading.value = true;
    var url = "http://localhost:8080/pedidos/editar/${pedido.id}";
    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(pedido.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        listarPedidos(); // Atualiza a lista após editar
      } else {
        print('Erro ao editar pedido');
      }
    } catch (e) {
      print('Erro ao editar pedido: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para deletar um pedido
  Future<bool> deletarPedido(String id) async {
    isLoading.value = true; // Inicia o carregamento
    try {
      var resposta = await _pedidoService.deletarPedido(id);
      if (resposta) {
        pedido.removeWhere((pedido) => pedido.id == id); // Remove o pedido da lista
        return true; // Retorna verdadeiro se o pedido foi deletado com sucesso
      }
      return false; // Retorna falso se não conseguir deletar
    } catch (e) {
      print('Erro ao deletar pedido: $e');
      return false; // Retorna falso em caso de erro
    } finally {
      isLoading.value = false; // Finaliza o carregamento
    }
  }


}
