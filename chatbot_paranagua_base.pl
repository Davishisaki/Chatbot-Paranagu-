:- use_module(library(odbc)).

% Configuração do banco de dados
connect_to_db :-
    odbc_connect('MySQLDSN', _Connection, [user('aluno'), password('aluno'), alias(mydb), open(once)]).

% Função para consultar dados e usar assertz
consult_and_assert :-
    connect_to_db,
    odbc_query(mydb, 'SELECT pergunta, resposta FROM pergunta_resposta', row(Pergunta, Resposta)),
    assertz(pergunta_resposta(Pergunta, Resposta)),
    fail; % Força a falha para continuar a busca por mais resultados
    odbc_disconnect(mydb).

% Exemplo de uso
exemplo :-
    consult_and_assert,
    % Exibir todos os fatos adicionados
    %  forall(pergunta_resposta(Pergunta, Resposta), (write('Pergunta: '), write(Pergunta), write(', Resposta: '), write(Resposta), nl)).
    forall(pergunta_resposta(Pergunta, Resposta), (write('pergunta_resposta('), write(Pergunta),write(', '), write(Resposta),write(').'), nl)).