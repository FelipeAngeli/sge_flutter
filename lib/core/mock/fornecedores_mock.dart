import 'package:sge_flutter/models/fornecedor_model.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:uuid/uuid.dart';

class FornecedoresMock {
  static List<FornecedorModel> gerarFornecedoresComProdutos(
      List<ProdutoModel> produtos) {
    final uuid = const Uuid();
    return [
      FornecedorModel(
        id: uuid.v4(),
        nomeEmpresa: 'Empresa A',
        nomeFornecedor: 'João Silva',
        telefone: '12345678',
        email: 'joao@empresaA.com',
        produtos: [produtos[0].id],
        descricao: 'Fornecedor especializado em eletrônicos.',
        categoria: 'Eletrônicos',
        cnpj: '12345678000100',
      ),
      FornecedorModel(
        id: uuid.v4(),
        nomeEmpresa: 'Empresa B',
        nomeFornecedor: 'Maria Oliveira',
        telefone: '87654321',
        email: 'maria@empresaB.com',
        produtos: produtos.length > 1 ? [produtos[1].id] : [],
        descricao: 'Fornecedor líder em vestuário.',
        categoria: 'Vestuário',
        cnpj: '22345678000100',
      ),
      FornecedorModel(
        id: uuid.v4(),
        nomeEmpresa: 'Empresa C',
        nomeFornecedor: 'Carlos Pereira',
        telefone: '11223344',
        email: 'carlos@empresaC.com',
        produtos: produtos.map((p) => p.id).toList(),
        descricao: 'Fornecedor multissetorial com ampla variedade.',
        categoria: 'Serviços',
        cnpj: '32345678000100',
      ),
      FornecedorModel(
        id: uuid.v4(),
        nomeEmpresa: 'Empresa D',
        nomeFornecedor: 'Ana Souza',
        telefone: '99887766',
        email: 'ana@empresaD.com',
        produtos: [],
        descricao: 'Fornecedor de alimentos orgânicos.',
        categoria: 'Alimentos',
        cnpj: '42345678000100',
      ),
      FornecedorModel(
        id: uuid.v4(),
        nomeEmpresa: 'Empresa E',
        nomeFornecedor: 'Bruno Costa',
        telefone: '44556677',
        email: 'bruno@empresaE.com',
        produtos: [],
        descricao: 'Fornecedor especializado em papelaria e escritório.',
        categoria: 'Papelaria',
        cnpj: '52345678000100',
      ),
      FornecedorModel(
        id: uuid.v4(),
        nomeEmpresa: 'Empresa F',
        nomeFornecedor: 'Fernanda Lima',
        telefone: '55667788',
        email: 'fernanda@empresaF.com',
        produtos: [],
        descricao: 'Fornecedor de materiais de construção.',
        categoria: 'Construção',
        cnpj: '62345678000100',
      ),
      FornecedorModel(
        id: uuid.v4(),
        nomeEmpresa: 'Empresa G',
        nomeFornecedor: 'Gustavo Menezes',
        telefone: '66778899',
        email: 'gustavo@empresaG.com',
        produtos: [],
        descricao: 'Fornecedor de equipamentos médicos.',
        categoria: 'Saúde',
        cnpj: '72345678000100',
      ),
    ];
  }
}
