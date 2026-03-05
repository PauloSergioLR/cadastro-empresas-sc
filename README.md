# Cadastro de Empreendimentos de Santa Catarina

## 📋 Descrição do Projeto

Este projeto consiste em uma aplicação CRUD (Create, Read, Update, Delete) desenvolvida para gerenciar informações sobre empreendimentos localizados no estado de Santa Catarina.

A aplicação foi desenvolvida como parte do desafio prático do processo seletivo **IA para DEVs**, promovido pelo **SENAI/SC**, cujo objetivo é avaliar as competências técnicas dos candidatos no desenvolvimento de software, organização de código, versionamento e documentação.

O sistema permite cadastrar, consultar, editar e remover informações de empreendimentos por meio de uma interface simples e funcional.

---

# ⚙️ Tecnologias Utilizadas

O projeto foi desenvolvido utilizando as seguintes tecnologias:

- **DataFlex** — linguagem principal da aplicação
- **DataFlex Embedded Database** — mecanismo de persistência de dados
- **Git** — controle de versionamento
- **GitHub** — hospedagem do repositório

---

# 📁 Estrutura do Projeto

O projeto está organizado seguindo a estrutura padrão de aplicações DataFlex.

```
CadastroEmpresasSC
│
├── AppSrc
│   ├── config
│   ├── CadastroEmpresasSC.cfg
│   ├── CadastroEmpresasSC.src
│   ├── Empresa.sl
│   ├── Empresa.vw
│   └── Util.pkg
│
├── Data
│   ├── empresa.dat
│   ├── empresa.hdr
│   ├── empresa.k1
│   ├── empresa.k2
│   ├── empresa.tag
│   │
│   ├── endereco_empresa.dat
│   ├── endereco_empresa.hdr
│   ├── endereco_empresa.k1
│   ├── endereco_empresa.k2
│   ├── endereco_empresa.tag
│   │
│   ├── contato_empresa.dat
│   ├── contato_empresa.hdr
│   ├── contato_empresa.k1
│   ├── contato_empresa.k2
│   ├── contato_empresa.tag
│   │
│   └── Filelist.cfg
│
├── DDSrc
│   ├── cEMPRESADataDictionary.dd
│   ├── cENDERECO_EMPRESADataDictionary.dd
│   ├── cCONTATO_EMPRESADataDictionary.dd
│   ├── EMPRESA.fd
│   ├── ENDERECO_EMPRESA.fd
│   ├── CONTATO_EMPRESA.fd
│   └── DDClassList.xml
│
├── Programs
│   └── Config.ws
│
├── CadastroEmpresasSC.sws
├── README.md
└── .gitignore
```

### Descrição das principais pastas

AppSrc → Contém os arquivos principais da aplicação (interface e lógica)  
Data → Arquivos do banco de dados do DataFlex  
DDSrc → Data Dictionaries responsáveis pela manipulação das tabelas  
Programs → Contém o workspace e onde ficará o executável gerado após a compilação 

---

# 📌 Funcionalidades do Sistema

A tela permite o gerenciamento completo (CRUD) dos empreendimentos.

A aplicação utiliza **três tabelas principais** para organização dos dados:

- **EMPRESA** → dados principais do empreendimento
- **ENDERECO_EMPRESA** → informações de endereço do empreendimento
- **CONTATO_EMPRESA** → informações de contato

Essas tabelas são relacionadas pelo **ID da empresa**, permitindo manter os dados estruturados e organizados.

Funcionalidades disponíveis:

- **Consulta/Pesquisa** por CNPJ/CPF:
  - Pesquisa via **Prompt (lista)** e carregamento do registro selecionado;
  - Ao sair do campo CNPJ/CPF, o sistema valida o tamanho (11 ou 14) e, se existir cadastro, **carrega automaticamente** os dados do empreendimento.

- **Cadastro e Edição**:
  - Botão **Salvar** cria um novo empreendimento quando o CNPJ/CPF ainda não existe;
  - Se o empreendimento já existir, o botão **Salvar** atualiza os dados do cadastro;
  - O salvamento contempla também os dados de **Endereço** e **Contato** vinculados ao empreendimento.

- **Exclusão**:
  - Botão **Excluir** remove o empreendimento e também os registros relacionados de **Endereço** e **Contato** (quando existirem), mediante confirmação.

- **Utilidades**:
  - Botão **Limpar** para limpar os campos e preparar um novo cadastro;
  - Botão **Fechar** para encerrar a tela.

Campos gerenciados (mínimos do desafio + complementares):
- CNPJ/CPF
- Nome do empreendimento/empresa
- Nome do(a) empreendedor(a) responsável
- Município de Santa Catarina
- Segmento (Tecnologia, Comércio, Indústria, Serviços, Agronegócio)
- Contato (E-mail / Telefone / Celular)
- Status (Ativo/Inativo)
- Endereço (CEP, Logradouro, Número, Bairro, Complemento)

---

# ▶️ Como Executar o Projeto

## 1️⃣ Instalar o DataFlex Studio 24.0

Para executar o projeto é necessário possuir o **DataFlex Studio 24.0** instalado.

Acesse o site oficial de downloads:

https://download.dataflex.dev/downloads/dataflex/dataflex-studio-64#versions

Passos:

1. Clique na aba **Prior versions**
2. Selecione a versão **24.0**
3. Clique em **Download**

Para baixar o instalador será necessário criar uma conta no site da DataFlex.

Caso ainda não possua:

1. Clique em **Register**
2. Preencha os dados solicitados
3. Crie sua conta gratuitamente

Após criar a conta, faça login para liberar o download do instalador.

---

## 2️⃣ Instalar o DataFlex Studio 24.0

Após baixar o instalador:

1. Execute o arquivo de instalação
2. Siga os passos do instalador
3. Utilize as configurações padrão

---

## 3️⃣ Clonar o Repositório

Clone o repositório utilizando o comando abaixo:

```
git clone https://github.com/PauloSergioLR/cadastro-empresas-sc.git
```

Ou faça o download do projeto diretamente pelo GitHub.

---

## 4️⃣ Abrir o Workspace

1. Abra o **DataFlex Studio 24.0**
2. Clique em **Workspace → Open Workspace**
3. Navegue até a pasta do projeto
4. Abra o arquivo:

```
CadastroEmpresasSC.sws
```

---

## 5️⃣ Compilar o Projeto

Antes de compilar, altere a arquitetura para **32-bit** na barra superior do DataFlex Studio.

Depois siga os passos abaixo:

1. Clique no menu **Project**
2. Selecione **Compile `<CadastroEmpresasSC.src>`**

ou utilize o atalho:

```
F8
```

Isso irá compilar o projeto e gerar o executável da aplicação.

---

## 6️⃣ Executar a Aplicação

Após a compilação:

1. Clique no menu **Debug**
2. Selecione **Run `<CadastroEmpresasSC.exe>`**

ou utilize o atalho:

```
F5
```

A aplicação será iniciada e o sistema estará pronto para uso.

O executável gerado ficará localizado na pasta:

```
Programs
```

---

# 🎥 Vídeo Pitch

Neste vídeo é apresentada uma breve demonstração do funcionamento da aplicação, bem como as principais decisões técnicas adotadas durante o desenvolvimento.

Link do vídeo:

---

# 👨‍💻 Autor

Projeto desenvolvido por **Paulo Sergio** como parte do desafio prático do processo seletivo **IA para DEVs — SENAI/SC**.

🔗 LinkedIn
https://www.linkedin.com/in/paulo-sergio-lopes-a54411196/