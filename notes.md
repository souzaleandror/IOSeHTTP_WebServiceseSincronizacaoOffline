#### 28/08/2023

Curso de iOS e HTTP: Web Services e sincronização offline

@01-Conhecendo o projeto 

@@01
Apresentação

[00:00] Olá seja bem-vindo, seja bem-vinda a Alura, eu sou o Ândriu, um dos instrutores de iOS aqui da plataforma. A ideia desse curso é falarmos sobre requisições http. Então, relembrando, nós estamos utilizando o nosso app Alura ponto como base dos nossos estudos.
[00:19] Então caso você ainda não tenha visto, alguns cursos anteriores nós iniciamos esse projeto do zero, e fomos, ao passar do tempo, desenvolvendo novas funcionalidades. Agora é hora de falarmos um pouco sobre requisições http.

[00:34] Inconscientemente nós utilizamos o tempo todo nosso telefone, seja para fazer transferência bancária, pagar conta, aplicativos de mensagens, enfim, todos esses apps utilizam internet, tanto 3G, 4G ou wi-fi para enviar informações para o servidor do mundo todo, então é um assunto que é muito importante você saber, porque é um dos pilares do desenvolvimento, a todo instante fazermos requisições para serviços externos do nosso app.

[01:02] No curso anterior nós aprendemos a persistir informações com o Core Data, e a ideia agora é continuarmos com esse projeto, mas utilizando um servidor que nós vamos rodar local no nosso Mac, que na verdade vai simular um servidor já hospedado, em algum serviço, como o AWS, o Azure, Heroku, mas a ideia aqui é rodarmos esse projeto Alura ponto API forma local no nosso app, e acessar através do localhost para simular algumas requisições.

[01:34] Então ao decorrer do curso, você vai aprender a salvar um objeto no servidor, vamos usar o Postman para ver se realmente está sendo salvo, vamos também trabalhar com a listagem desses recibos de ponto que nós teremos aqui no nosso aplicativo.

[01:49] Então vamos salvar, vamos listar, vamos deletar e, à medida que o curso for avançando vamos falar de diversos conceitos importantes, como os verbos aqui da requisição, vamos falar o que podemos passar no header da requisição, como é que configuramos o body de requisição, como que transformamos um dicionário em binário para enviarmos em uma requisição.

[02:13] Então são coisas rotineiras que um desenvolvedor, uma desenvolvedora, acaba fazendo no dia a dia, e vamos aprender aqui como é que fazemos no nosso projeto. Vamos começar trabalhando com requisições de forma nativa, utilizando as classes do swift.

[02:29] E depois vamos ver também como é que funciona utilizando uma lib que facilita essas requisições para nós, que é o Alamofire. Vamos ver então como é que trabalhamos para persistir, listar e deletar esses elementos no nosso servidor local. Esse é o conteúdo então que nós vamos ver durante esse curso e eu espero você.

@@02
Projeto inicial

Para iniciar o curso, faça o download do projeto.
Bons estudos!

https://github.com/alura-cursos/2316-alura-ponto-parte2/archive/97149295535d3a9a209cc77862873a3907abd7ba.zip

@@03
Conhecendo a API

[00:00] A partir de agora nós vamos começar a conversar sobre um assunto bem importante quando falamos de desenvolvimento móvel, que é como que o aplicativo se comunica com serviços externos. O que eu quero dizer com isso?
[00:15] Quase 100% de todos apps que você utiliza, provavelmente fazem alguma requisição para algum tipo de serviço, e te devolve a resposta simultaneamente, conforme você utiliza esse aplicativo.

[00:27] Então se pensarmos em um aplicativo de banco, quando você faz uma transferência, quando você paga um boleto, inconscientemente, você está enviando informações para algum servidor, esse servidor processa todas as informações e dados que você enviou, e ele te devolve uma resposta. A resposta pode ser sucesso, pode ser error, pode ser vários tipos de resposta.

[00:50] E o que eu quero dizer com isso? Até então, nós estamos utilizando, a persistência de dados e todas as coisas que nós fizemos no nosso app. Nós estamos fazendo de forma local, isso significa que se eu apagar o app no meu iPhone, apagar o app do simulador, nós perdemos todas as informações. Como é que solucionamos isso então?

[01:14] É justamente utilizando requisições http, onde nós vamos nos comunicar com o servidor, onde nós podemos salvar, podemos deletar, podemos atualizar informações que nós enviarmos a esse serviço. Então conseguimos fazer várias operações nesse servidor e, se eu deletar o app, se eu apagar, instalar de novo, basta eu fazer uma requisição para o servidor e ele vai me devolver todas as informações, porque elas não vão mais estar local no meu app, e sim hospedado em algum lugar na nuvem.

[01:51] No nosso caso aqui no curso vamos utilizar o nosso próprio Mac para fazer um servidor, mas normalmente esses serviços são hospedados na AWS, no Azure, da Microsoft, no Heroku. Então tem vários serviços de hospedagem para este tipo de aplicação, que é o que chamamos, na verdade, de projetos em back-end.

[02:15] Então, para começarmos, eu queria apresentar para você esse projeto Alura Ponto API. Trazendo isso para o nosso contexto, estamos trabalhando com o nosso aplicativo de registro de ponto, então podemos, na verdade, salvar um registro, bater o ponto e tudo mais, como nós já fizemos nos outros cursos. Ele mostra aqui nessa lista todos os recibos. Mas como eu disse, nós temos esse problema, se apagarmos o app e rodar ele de novo, perdemos todas as informações.

[02:49] Vamos utilizar então esse projeto para criar um servidor local no nosso Mac e conseguirmos, então, usar como base para estudar um pouco mais sobre requisições. O que esse projeto faz?

[03:02] Aqui temos toda a documentação, inclusive esse link que vai estar disponível para você, nessa sessão aqui do curso, então você pode clicar lá e você vai ter acesso à mesma página que eu estou te mostrando agora.

[03:14] Vamos ver passo a passo, com calma ao decorrer do curso. Agora eu queria mostrar para você esse ponto aqui, acesso ao projeto. Então você pode acessar o código fonte do projeto, ou você pode clicar aqui nesse link para baixar o jar executável, que é o que nós vamos utilizar aqui no curso.

[03:32] Então eu vou pedir para que você baixe esse arquivo. Depois disso, nós temos aqui um arquivo parecido com esse, que eu deixei dentro dessa pasta, que é esse “server.jar”. É ele que vamos utilizar. E como é que eu utilizo então esse projeto? Aqui tem toda documentação do projeto, aqui ele dá uma dica de como é que executamos, que é esse java-jar e nome do arquivo. É isso que nós vamos precisar.

[04:07] Um ponto importante para que você não tenha nenhum problema, estamos mostrando, e eu vou executar esse projeto, nessa versão 11 do Java. Então, para que você consiga acompanhar sem nenhum problema, é interessante que você esteja utilizando a mesma versão.

[04:26] Agora o que que eu vou fazer? Eu vou executar aquele arquivo que eu tenho aqui nessa pasta, então eu vou abrir o terminal e como é que executo? Eu vou digitar o comando java -jar e eu clico e arrasto para obter o caminho desse “server.jar” aqui no terminal. Então ele copia o comando, na verdade, o path, o caminho onde está o arquivo.

[04:54] Quando eu faço isso, ele vai aqui executar vários scripts, mas isso significa que eu já tenho um projeto rodando aqui no meu Mac, então a partir de agora eu já consigo utilizar esse serviço.

[05:10] Então, a princípio, esse primeiro vídeo é para contextualizar para você, como é que vamos caminhar ao decorrer desse curso, utilizando essa API, que é esse serviço externo que nós vamos rodar no nosso Mac, criando um servidor local, vamos acessar inclusive através do localhost, e ele vai servir de base para manipularmos os recibos do nosso app através de requisição http.

@@04
Para saber mais: Baixando arquivo do servidor

Neste primeiro capítulo, tivemos uma visão geral do que utilizaremos para salvar os registros de pontos em um servidor através de requisições http.
Você pode ver a documentação e fazer o download do projeto através deste link.

https://github.com/alura-cursos/alura-ponto

https://github.com/alura-cursos/alura-ponto/archive/refs/heads/dev.zip

https://github.com/alura-cursos/alura-ponto/tree/dev

https://github.com/alura-cursos/alura-ponto/releases/download/0.0.1/server.jar

@@05
Faça como eu fiz: Alura ponto API

Alura Ponto API é uma aplicação back-end para gerenciar registro de pontos. A aplicação foi desenvolvida em Kotlin, utilizando o Spring Boot e versão do Java 11.

Agora, você pode fazer o download do arquivo do servidor através deste link.
Ne seção de acesso ao projeto, baixe o jar executável.

https://github.com/alura-cursos/alura-ponto

@@06
O que aprendemos?

Nesta primeira aula, entendemos quais implementações e problemas vamos resolver ao decorrer do curso, e também aprendemos a baixar e configurar o projeto.