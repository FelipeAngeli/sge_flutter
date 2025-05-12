# SGE Flutter

Sistema de Gestão Empresarial desenvolvido em Flutter, utilizando arquitetura MVVM (Model-View-ViewModel), Supabase para autenticação e Hive para banco de dados local.

## 🚀 Sobre o Projeto

Este é um projeto MVP (Minimum Viable Product) de um Sistema de Gestão Empresarial, desenvolvido com Flutter para oferecer uma experiência multiplataforma. O sistema foi construído com foco em escalabilidade, manutenibilidade e boas práticas de desenvolvimento.

## 🏗️ Arquitetura

O projeto segue a arquitetura MVVM (Model-View-ViewModel), que oferece uma clara separação de responsabilidades:

- **Model**: Representa os dados e a lógica de negócios
- **View**: Interface do usuário e componentes visuais
- **ViewModel**: Gerencia o estado e a lógica de apresentação

### Estrutura de Diretórios

```
lib/
├── app/           # Configurações do app
├── core/          # Funcionalidades core
├── data/          # Camada de dados
├── models/        # Modelos de dados
├── modules/       # Módulos da aplicação
└── shared/        # Componentes compartilhados
```

## 🛠️ Tecnologias Principais

### Gerenciamento de Estado e Navegação
- **flutter_bloc**: Gerenciamento de estado usando BLoC pattern
- **flutter_modular**: Injeção de dependência e roteamento
- **equatable**: Comparação de objetos

### Armazenamento Local
- **hive**: Banco de dados local rápido e leve
- **hive_flutter**: Integração do Hive com Flutter

### Backend e Autenticação
- **supabase_flutter**: Backend as a Service (BaaS) e autenticação
- **dio**: Cliente HTTP para requisições

### UI/UX
- **charts_painter**: Criação de gráficos
- **qr_flutter**: Geração de QR Codes
- **printing**: Geração de PDFs

### Utilitários
- **intl**: Internacionalização
- **uuid**: Geração de IDs únicos
- **flutter_dotenv**: Gerenciamento de variáveis de ambiente

## 🔐 Autenticação

O sistema utiliza o Supabase para gerenciar autenticação, oferecendo:
- Login com email/senha
- Cadastro de usuários
- Recuperação de senha
- Validação de email

## 📱 Funcionalidades

- Autenticação de usuários
- Gestão de usuários
- Interface responsiva
- Validações em tempo real
- Feedback visual para o usuário

## 🚀 Como Executar

1. Clone o repositório
2. Instale as dependências:
```bash
flutter pub get
```
3. Configure as variáveis de ambiente no arquivo `.env`
4. Execute o projeto:
```bash
flutter run
```

## 🔧 Desenvolvimento

### Gerar código Hive
```bash
flutter pub run build_runner build
```

### Limpar cache
```bash
flutter clean
flutter pub get
```

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👥 Contribuição

Contribuições são bem-vindas! Por favor, leia as diretrizes de contribuição antes de submeter um pull request.

## 📫 Contato

Para mais informações ou suporte, entre em contato através dos canais disponíveis.
