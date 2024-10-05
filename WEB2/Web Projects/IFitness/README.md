
---

# iFitness

**iFitness** é um projeto desenvolvido como parte das aulas de WEB2 no Instituto Federal de São Paulo (IFSP) - Campus Araraquara. O objetivo do projeto é criar uma aplicação web para o acompanhamento de atividades físicas, utilizando uma stack de tecnologias modernas e seguindo boas práticas de desenvolvimento web.

## 🛠️ Tecnologias Utilizadas


- **Linguagens**:  
  ![Java](https://img.shields.io/badge/-Java-007396?style=flat-square&logo=java&logoColor=white)

- **Ferramentas e Frameworks**:  
  ![Servlet](https://img.shields.io/badge/-Servlet-4285F4?style=flat-square&logo=java&logoColor=white)
  ![JSP](https://img.shields.io/badge/-JSP-4285F4?style=flat-square&logo=java&logoColor=white)
  ![Bootstrap](https://img.shields.io/badge/-Bootstrap-4285F4?style=flat-square&logo=java&logoColor=white)


- **Banco de Dados**:  
  ![MySQL](https://img.shields.io/badge/-MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
- **Versionamento**:  
  ![Git](https://img.shields.io/badge/-Git-F05032?style=flat-square&logo=git&logoColor=white)
  ![GitHub](https://img.shields.io/badge/-GitHub-181717?style=flat-square&logo=github)

---

## Funcionalidades

- **Cadastro de Usuários**: Permite o registro de novos usuários.
- **Login e Autenticação**: Controle de acesso à aplicação com autenticação por sessão.
- **Registro de Atividades**: Cadastro e acompanhamento de atividades físicas (caminhada, ciclismo, corrida, natação).
- **Visualização de Relatórios**: Exibe gráficos e relatórios sobre o desempenho das atividades.
- **Integração com Banco de Dados**: Utilização do MySQL para armazenar dados de forma persistente.

[//]: # (## Estrutura do Projeto)

[//]: # ()
[//]: # (```)

[//]: # (iFitness/)

[//]: # (│)

[//]: # (├── src/)

[//]: # (│   ├── main/)

[//]: # (│   │   ├── java/)

[//]: # (│   │   │   ├── controllers/         # Servlets responsáveis pela lógica de controle)

[//]: # (│   │   │   ├── models/              # Modelos de dados e conexão com o banco)

[//]: # (│   │   │   └── utils/               # Utilitários e classes auxiliares)

[//]: # (│   │   └── webapp/)

[//]: # (│   │       ├── css/                 # Arquivos de estilo CSS)

[//]: # (│   │       ├── js/                  # Scripts JavaScript)

[//]: # (│   │       └── WEB-INF/             # Configurações do Tomcat e arquivos JSP)

[//]: # (│   └── resources/                   # Arquivos de configuração e dados)

[//]: # (│)

[//]: # (└── pom.xml                           # Arquivo de configuração do Maven)

[//]: # (```)

[//]: # ()
[//]: # (## Requisitos)

[//]: # ()
[//]: # (- **JDK 11+**: Versão mínima do Java para rodar o projeto.)

[//]: # (- **Apache Tomcat 9+**: Servidor de aplicação para deploy da aplicação.)

[//]: # (- **MySQL 8+**: Banco de dados relacional.)

[//]: # (- **Maven**: Gerenciamento de dependências e build.)

[//]: # ()
[//]: # (## Configuração)

[//]: # ()
[//]: # (1. Clone este repositório:)

[//]: # ()
[//]: # (```bash)

[//]: # (git clone https://github.com/seu-usuario/ifitness.git)

[//]: # (```)

[//]: # ()
[//]: # (2. Configure o banco de dados MySQL:)

[//]: # ()
[//]: # (    - Crie um banco de dados chamado `ifitness`.)

[//]: # (    - Importe o arquivo `schema.sql` localizado na pasta `resources` para configurar as tabelas.)

[//]: # ()
[//]: # (3. Configure o arquivo `db.properties` para conectar ao banco de dados:)

[//]: # ()
[//]: # (```properties)

[//]: # (db.url=jdbc:mysql://localhost:3306/ifitness)

[//]: # (db.username=root)

[//]: # (db.password=sua_senha)

[//]: # (```)

[//]: # ()
[//]: # (4. Compile o projeto e faça o deploy no Tomcat:)

[//]: # ()
[//]: # (```bash)

[//]: # (mvn clean package)

[//]: # (```)

[//]: # ()
[//]: # (5. Inicie o Tomcat e acesse a aplicação no navegador:)

[//]: # ()
[//]: # (```)

[//]: # (http://localhost:8080/ifitness)