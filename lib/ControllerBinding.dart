import 'package:conectar_api/controllers/clienteController.dart';
import 'package:conectar_api/controllers/pedidoController.dart';
import 'package:get/get.dart';

class ControllerBinding implements Bindings{
  @override
  void dependencies() {
      Get.lazyPut<PedidoController>(() => PedidoController());
      Get.lazyPut<ClienteController>(() => ClienteController());
  }

}