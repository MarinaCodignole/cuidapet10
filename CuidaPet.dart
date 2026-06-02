import 'dart:io';

void main() {
  CuidaPet sistema = CuidaPet();
  sistema.iniciar();
}

class Produto {
  int codigo;
  String nome;
  double valor;

  Produto(this.codigo, this.nome, this.valor);
}

class Cliente {
  String nome;

  Cliente(this.nome);
}

class Carrinho {
  List<Produto> itens = [];

  void adicionar(Produto produto) {
    if (itens.length == 3) {
      print("Carrinho cheio!");
      return;
    }

    itens.add(produto);
    print("${produto.nome} adicionado ao carrinho.");
  }

  void listar() {
    print("\n=== CARRINHO ===");

    if (itens.isEmpty) {
      print("Carrinho vazio.");
      return;
    }

    for (Produto p in itens) {
      print("${p.nome} - R\$ ${p.valor}");
    }
  }

  double calcularTotal() {
    double total = 0;

    for (Produto p in itens) {
      total += p.valor;
    }

    return total;
  }
}

class Venda {
  int totalVendas = 0;
  double valorTotalVendas = 0;

  void registrar(double valor) {
    totalVendas++;
    valorTotalVendas += valor;
  }

  void mostrarResumo() {
    print("\n=== FIM DO DIA ===");
    print("Quantidade de vendas: $totalVendas");
    print(
        "Valor total vendido: R\$ ${valorTotalVendas.toStringAsFixed(2)}");
  }
}

class CuidaPet {
  Venda venda = Venda();

  final List<Produto> produtos = [
    Produto(101, "Ração Cachorros", 290.00),
    Produto(102, "Ração Gatos", 492.00),
    Produto(103, "Bifinho", 23.00),
    Produto(104, "Bola", 38.00),
  ];

  final List<Produto> servicos = [
    Produto(201, "Banho e tosa", 55.99),
    Produto(202, "Tosa higiênica", 12.99),
    Produto(203, "Hidratação", 20.99),
  ];

  void iniciar() {
    while (true) {
      mostrarBoasVindas();

      String nome = lerTexto();

      if (nome == "cuidapetrestrito") {
        double valor = areaRestrita();
        venda.registrar(valor);
        continue;
      }

      Cliente cliente = Cliente(nome);
      Carrinho carrinho = Carrinho();

      menuCliente(cliente, carrinho);

      if (!novoCliente()) {
        break;
      }
    }

    venda.mostrarResumo();
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

  void menuCliente(Cliente cliente, Carrinho carrinho) {
    while (true) {
      print("\nOlá ${cliente.nome}");
      print("1 Ver promoções");
      print("2 Solicitar serviço");
      print("3 Listar carrinho");
      print("4 Finalizar compra");
      print("0 Sair");

      int opcao = int.parse(lerTexto());

      if (opcao == 0) {
        break;
      }

      switch (opcao) {
        case 1:
          menuPromocoes(carrinho);
          break;

        case 2:
          menuServicos(carrinho);
          break;

        case 3:
          carrinho.listar();
          break;

        case 4:
          double total = finalizarCompra(carrinho);
          venda.registrar(total);
          break;

        default:
          print("Opção inválida");
      }
    }
  }

  void menuPromocoes(Carrinho carrinho) {
    print("\n101 - Ração Cachorros R\$ 290.00");
    print("102 - Ração Gatos R\$ 492.00");
    print("103 - Bifinho R\$ 23.00");
    print("104 - Bola R\$ 38.00");
    print("8 - Adicionar ao carrinho");

    int escolha = int.parse(lerTexto());

    if (escolha == 8) {
      adicionarProduto(carrinho);
    }
  }

  void menuServicos(Carrinho carrinho) {
    print("\n201 - Banho e tosa R\$ 55.99");
    print("202 - Tosa higiênica R\$ 12.99");
    print("203 - Hidratação R\$ 20.99");
    print("8 - Adicionar ao carrinho");

    int escolha = int.parse(lerTexto());

    if (escolha == 8) {
      adicionarServico(carrinho);
    }
  }

  void adicionarProduto(Carrinho carrinho) {
    print("Digite o código:");

    int codigo = int.parse(lerTexto());

    for (Produto p in produtos) {
      if (p.codigo == codigo) {
        carrinho.adicionar(p);
        return;
      }
    }

    print("Código inválido");
  }

  void adicionarServico(Carrinho carrinho) {
    print("Digite o código:");

    int codigo = int.parse(lerTexto());

    for (Produto s in servicos) {
      if (s.codigo == codigo) {
        carrinho.adicionar(s);
        return;
      }
    }

    print("Código inválido");
  }

  double finalizarCompra(Carrinho carrinho) {
    double total = carrinho.calcularTotal();

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

    String resposta = lerTexto().toUpperCase();

    return resposta != "N";
  }
}