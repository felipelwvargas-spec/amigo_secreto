// Importa bibliotecas necessárias
import 'dart:async'; // Para trabalhar com Stream e StreamController
import 'package:http/http.dart'; // Para fazer requisições HTTP (get, post, etc.)
import 'dart:convert'; // Para converter JSON em Map/List e vice-versa
import 'package:amigo_secreto/api_key.dart'; // Onde está armazenada a chave de autenticação do GitHub (githubApiKey)

class AccountServices {
  // Cria um controlador de stream que vai emitir mensagens (Strings)
  StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
      // URL do Gist a ser atualizado
    String url =
        "https://api.github.com/gists/b49d630bd597c03ed8b9b90d498e7f5a";

  Future<List<dynamic>> getAll() async {
    // Faz a requisição GET aguardando o resultado
    Response response = await get(Uri.parse(url));

    _streamController.add(
      "${DateTime.now()} - Dados requisitados (status: ${response.statusCode})",
    );

    // Retorna a lista decodificada do JSON (contas)
    return json.decode(response.body);
  }

  addAccount(Map<String, dynamic> mapAccount) async {
    // Busca os dados existentes no Gist (lista de contas)
    List<dynamic> listAccounts = await getAll();

    // Adiciona a nova conta à lista
    listAccounts.add(mapAccount);

    // Converte a lista completa de volta pra JSON
    String content = json.encode(listAccounts);



    // Envia os novos dados via POST (GitHub API)
    Response response = await post(
      Uri.parse(url),
      headers: {
        // Usa o token pessoal para autenticação no GitHub
        "Authorization": "Bearer $githubApiKey",
      },
      body: json.encode({
        // Define a estrutura exigida pela API do GitHub
        "description": "Accounts.json",
        "public": true,
        "files": {
          "accounts.json": {
            "content": content, // Aqui vai o novo conteúdo do arquivo JSON
          },
        },
      }),
    );

    // Se o status code começar com "2" (ex: 200, 201), significa sucesso
    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
        "${DateTime.now()} - Dados inseridos (${mapAccount['name']})",
      );
    } else {
      _streamController.add(
        "${DateTime.now()} - Erro ao inserir dados (status: ${response.statusCode} ${mapAccount['name']})",
      );
    }
  }
}
