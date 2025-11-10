// Importa bibliotecas necessárias
import 'dart:async'; // Para trabalhar com Stream e StreamController
import 'package:http/http.dart'; // Para fazer requisições HTTP (get, post, etc.)
import 'dart:convert'; // Para converter JSON em Map/List e vice-versa
import 'package:amigo_secreto/api_key.dart'; // Onde está armazenada a chave de autenticação do GitHub (githubApiKey)

// Cria um controlador de stream que vai emitir mensagens (Strings)
StreamController<String> streamController = StreamController<String>();

void main() {
  // Cria uma "assinatura" para escutar eventos emitidos pela stream
  // Sempre que algo for adicionado em streamController.add(), esta função será executada
  StreamSubscription<String> streamSubscription =
      streamController.stream.listen((String info) {
    print("Evento recebido: $info");
  });

  // Faz uma requisição HTTP usando Future.then()
  // (modo tradicional de lidar com assincronismo)
  requestData();

  // Faz a mesma requisição, mas usando async/await
  // (modo moderno e mais legível)
  requestDataAsync();

  // Envia novos dados (simulando inserção de uma conta)
  sendDataAsync({
    "id": "ID011",
    "name": "Felipe",
    "lastName ": "Vargas",
    "balance": 3500.0,
  });
}


requestData() {
  String url =
      "https://gist.githubusercontent.com/felipelwvargas-spec/b49d630bd597c03ed8b9b90d498e7f5a/raw/1c7f0619d6efe6f24506d2402bdab1c1ca936c4c/accounts.json";

  // Cria um Future de uma requisição GET
  Future<Response> futureResponse = get(Uri.parse(url));

  // Quando a resposta chegar, executa o then()
  futureResponse.then((Response response) {
    // Envia uma mensagem para a stream informando que os dados foram recebidos
    streamController.add("${DateTime.now()} - Dados recebidos (then)");
  });
}


Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/felipelwvargas-spec/b49d630bd597c03ed8b9b90d498e7f5a/raw/1c7f0619d6efe6f24506d2402bdab1c1ca936c4c/accounts.json";

  // Faz a requisição GET aguardando o resultado
  Response response = await get(Uri.parse(url));

  // Retorna a lista decodificada do JSON (contas)
  return json.decode(response.body);
}


sendDataAsync(Map<String, dynamic> mapAccount) async {
  // Busca os dados existentes no Gist (lista de contas)
  List<dynamic> listAccounts = await requestDataAsync();

  // Adiciona a nova conta à lista
  listAccounts.add(mapAccount);

  // Converte a lista completa de volta pra JSON
  String content = json.encode(listAccounts);

  // URL do Gist a ser atualizado
  String url = "https://api.github.com/gists/b49d630bd597c03ed8b9b90d498e7f5a";

  // Envia os novos dados via POST (GitHub API)
  Response response = await post(
    Uri.parse(url),
    headers: {
      // Usa o token pessoal para autenticação no GitHub
      "Authorization": "Bearer $githubApiKey"
    },
    body: json.encode({
      // Define a estrutura exigida pela API do GitHub
      "description": "Accounts.json",
      "public": true,
      "files": {
        "accounts.json": {
          "content": content // Aqui vai o novo conteúdo do arquivo JSON
        }
      }
    }),
  );

  // Se o status code começar com "2" (ex: 200, 201), significa sucesso
  if (response.statusCode.toString()[0] == "2") {
    streamController.add(
        "${DateTime.now()} - Dados inseridos (${mapAccount['name']})");
  } else {
    print("Erro ao enviar dados: ${response.statusCode}");
  }
}

