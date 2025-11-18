// Ponto de entrada da aplicação.
// Este arquivo atualmente executa uma transação de teste utilizando
// `TransactionService`. Em um aplicativo real, a chamada a serviço
// viria de uma camada de UI ou de uma lógica de negócio com dados
// fornecidos pelo usuário.

import 'package:amigo_secreto/screens/account_screens.dart';
// import 'package:amigo_secreto/exceptions/transaction_exceptions.dart';
// import 'package:amigo_secreto/services/transaction_service.dart';

void main() {

  AccountScreen accountScreen = AccountScreen();
  accountScreen.initializeStream();
  accountScreen.runChatBot();




  // TransactionService()
  //     .makeTransaction(idSender: "ID001", idReceiver: "ID002", amount: 5000)
  //     .catchError((e) {
  //       print(e.message);
  //       print(
  //         "${e.cause.name}Possui saldo ${e.cause.balance}"
  //         " que é menor que ${(e.amount + e.taxes)}",
  //       );
  //     }, test: (error) => error is InsufficientFundsException)
  //     .then((value) {});

  // void main() async {
  //   // Exemplo de uso rápido: cria uma transação entre duas contas (IDs).
  //   // - `idSender` e `idReceiver` representam os identificadores das contas.
  //   // - `amount` é o valor a ser transferido.
  //   // Em produção, não use IDs hardcoded; obtenha-os via input ou do seu DB.

  //   try {
  //   await TransactionService().makeTransaction(
  //     idSender: "ID001",
  //     idReceiver: "ID002",
  //     amount: 5000,
  //   );
  // } on InsufficientFundsException catch (e) {
  //   print(e.message);
  //   print("${e.cause.name}Possui saldo ${e.cause.balance}" " que é menor que ${(e.amount + e.taxes)}");
  //   // TODO
  // }

  // Código comentado: exemplo de como iniciar a interface de chat/CLI
  // para gerenciar contas interativamente. Descomente se quiser usar.
  // AccountScreen accountScreen = AccountScreen();
  // accountScreen.initializeStream();
  // accountScreen.runChatBot();

  // Abaixo existem blocos de código antigos/commentados que eram usados
  // para testes e demonstrações de fluxo (funções aninhadas, prints etc.).
  // Mantive para referência; remova se não for mais necessário.

  // void main() {
  //   print("Começou a main");
  //   function01();
  //   print("Finalizou a main");
  // }

  // void function01() {
  //   print("Começou a Função 01");
  //   function02();
  //   print("Finalizou a Função 01");
  // }

  // void function02() {
  //   print("Começou a Função 02");
  //   for (int i = 1; i <= 5; i++) {
  //     print(i);
  //   }
  //   print("Finalizou a Função 02");
  // }
}
