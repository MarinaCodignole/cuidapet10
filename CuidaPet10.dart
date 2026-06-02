import 'dart:io';

void main() {
  int totalVendas = 0;
  double valorTotalVendas = 0;

  while (true) {
    mostrarBoasVindas();
    String nome = lerTexto();

    if (nome == "cuidapetrestrito") {
      double valor = areaRestrita();
      totalVendas++;
      valorTotalVendas += valor;
      continue;
    }

    List<String> carrinhoNomes = [];
    List<double> carrinhoValores = [];

    menuCliente(nome, carrinhoNomes, carrinhoValores, 
      (double valorCompra) {
        totalVendas++;
        valorTotalVendas += valorCompra;
      }
    );

    if (!novoCliente()) break;
  }

  mostrarFimDoDia(totalVendas, valorTotalVendas);
}

void mostrarBoasVindas() {
  print("\nBem vindo ao autoatendimento do Cuidapet");
  print("Digite seu nome:");
}

String lerTexto() {
  return stdin.readLineSync()!;
}

double areaRestrita() {
  print("\n=== ÁREA RESTRITA FUNCIONÁRIO ===");
  print("Nome do cliente:");
  String cliente = lerTexto();

  print("Valor gasto:");
  double valor = double.parse(lerTexto());

  print("Forma de pagamento (D-para débito/C-para crédito):");
  String forma = lerTexto().toUpperCase();

  if (forma == "D") {
    valor *= 0.9;
  }

  print("Valor final: R\$ ${valor.toStringAsFixed(2)}");
  return valor;
}


void menuCliente(String nome, List<String> nomes, List<double> valores,
    Function(double) registrarVenda) {

  while (true) {
    print("\nOlá $nome");
    print("1 Ver promoções");
    print("2 Solicitar serviço");
    print("3 Listar carrinho");
    print("4 Finalizar compra");
    print("0 Sair");

    int opcao = int.parse(lerTexto());
    if (opcao == 0) break;

    switch (opcao) {
      case 1:
        menuPromocoes(nomes, valores);
        break;
      case 2:
        menuServicos(nomes, valores);
        break;
      case 3:
        listarCarrinho(nomes, valores);
        break;
      case 4:
        double total = finalizarCompra(valores);
        registrarVenda(total);
        break;
      default:
        print("Opção inválida");
    }
  }
}

void menuPromocoes(List<String> nomes, List<double> valores) {
  print("\n101 - Ração Cachorros R\$ 290.00");
  print("102 - Ração Gatos R\$ 492.00");
  print("103 - Bifinho R\$ 23");
  print("104 - Bola R\$ 38");
  print("8 - Adicionar ao carrinho");

  int escolha = int.parse(lerTexto());

  if (escolha == 8) {
    adicionarProduto(nomes, valores);
  }
}

void menuServicos(List<String> nomes, List<double> valores) {
  print("\n201 - Banho e tosa R\$ 55.99");
  print("202 - Tosa higiênica R\$ 12.99");
  print("203 - Hidratação R\$ 20.99");
  print("8 - Adicionar ao carrinho");

  int escolha = int.parse(lerTexto());

  if (escolha == 8) {
    adicionarServico(nomes, valores);
  }
}

void adicionarProduto(List<String> nomes, List<double> valores) {
  if (nomes.length == 3) {
    print("Carrinho cheio!");
    return;
  }

  print("Digite o código:");
  int codigo = int.parse(lerTexto());

  switch (codigo) {
    case 101:
      nomes.add("Ração Cachorros");
      valores.add(290.00);
      break;
    case 102:
      nomes.add("Ração Gatos");
      valores.add(492.00);
      break;
    case 103:
      nomes.add("Bifinho");
      valores.add(23);
      break;
    case 104:
      nomes.add("Bola");
      valores.add(38);
      break;
    default:
      print("Código inválido");
  }
}

void adicionarServico(List<String> nomes, List<double> valores) {
  if (nomes.length == 3) {
    print("Carrinho cheio!");
    return;
  }

  print("Digite o código:");
  int codigo = int.parse(lerTexto());

  switch (codigo) {
    case 201:
      nomes.add("Banho e tosa");
      valores.add(55.99);
      break;
    case 202:
      nomes.add("Tosa higiênica");
      valores.add(12.99);
      break;
    case 203:
      nomes.add("Hidratação");
      valores.add(20.99);
      break;
    default:
      print("Código inválido");
  }
}

void listarCarrinho(List<String> nomes, List<double> valores) {
  print("\n=== CARRINHO ===");
  for (int i = 0; i < nomes.length; i++) {
    print("${nomes[i]} R\$ ${valores[i]}");
  }
}

double finalizarCompra(List<double> valores) {
  double total = 0;
  for (double v in valores) {
    total += v;
  }

  print("Forma de pagamento (D-para débito/C-para crédito):");
  String forma = lerTexto().toUpperCase();

  if (forma == "D") {
    total *= 0.9;
  }

  print("Valor final: R\$ ${total.toStringAsFixed(2)}");
  return total;
}

bool novoCliente() {
  print("\nDeseja atender novo cliente? (S/N)");
  String resp = lerTexto().toUpperCase();
  return resp != "N";
}

void mostrarFimDoDia(int totalVendas, double valorTotal) {
  print("\n=== FIM DO DIA ===");
  print("Quantidade de vendas: $totalVendas");
  print("Valor total vendido: R\$ ${valorTotal.toStringAsFixed(2)}");
}