import 'dart:convert';

import 'package:conectar_api/models/LojaModel.dart';
import 'package:conectar_api/models/PedidoModel.dart';
import 'package:http/http.dart' as http;
class ClienteService{
  dynamic _response;
  String url ="http://localhost:8080/loja/salvar";
  PedidoService(){
    _response = "";
  }

  Future<List<ClienteModel>> listarClientes() async{
    try{
      _response = await http.get(
        Uri.parse("http://localhost:8080/clientes/listar"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
      //veridfica status resposta do servidor
      if(_response.statusCode == 200){
        List<dynamic> jsonListClientes =
        json.decode(utf8.decode(_response.bodyBytes));
        return
          jsonListClientes.map((item) => ClienteModel.fromJson(item)).toList();
      }else{
        return [];
      }
    }catch(e){
      return [];
    }
  }


}