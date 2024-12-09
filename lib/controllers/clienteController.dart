import 'package:conectar_api/models/LojaModel.dart';
import 'package:get/get.dart';

import '../services/clienteService.dart';

class ClienteController extends GetxController{
  ClienteService _clienteService = ClienteService();

  var isLoading = false.obs;
  static ClienteController get clienteController => Get.find();
  var clientes = <ClienteModel>[].obs;

  Future<void> listarClientes() async {
    //indica que carregar é verdadeiro
    isLoading.value = true;
    try{
      var lista = await _clienteService.listarClientes();
      if(lista != null){
        clientes.assignAll(lista);
      }
      else{
        clientes.clear();
      }
    }
    catch(e){
      clientes.clear();
      print('Erro ao listar clientes: $e');
    }
    finally {
      isLoading.value = false;
      update();
    }
  }

  // Método para obter um cliente pelo ID
  ClienteModel? obterClientePorId(String id) {
    return clientes.firstWhereOrNull((cliente) => cliente.id == id);
  }


}

