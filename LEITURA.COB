       IDENTIFICATION DIVISION.
       PROGRAM-ID. CLIENTES.
      ******************************************************************
      * PROGRAMA PARA LER DADOS DE CLIENTES E VALIDAR SALDO/CONTA      *
      * AUTOR:     YURI                                              *
      * DATA:      18/08/2025                                          *
      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WRK-DADOS-CLIENTE.
           05 WRK-NOME          PIC X(20) VALUE SPACES.
      * DEFINIDO COM 2 CASAS DECIMAIS (V99) PARA ARMAZENAR CENTAVOS
           05 WRK-SALDO         PIC S9(08)V99 COMP VALUE ZEROS.
           05 WRK-TIPO-CONTA    PIC X(01) VALUE SPACES.
      * LEVEL 88 PARA DEIXAR AS CONDICOES MAIS LEGIVEIS
              88 TIPO-VALIDO    VALUE "C", "P".
              88 FIM-PROCESSAMENTO VALUE "F".

       01  WRK-DADOS-EDICAO.
           05 WRK-SALDO-ED      PIC Z.ZZZ.ZZ9,99.

       01  WRK-CONTROLE.
      * COMP-3 (PACKED-DECIMAL) E MAIS COMUM PARA CONTADORES
           05 WRK-CONTADOR      PIC 9(03) USAGE COMP-3 VALUE ZEROS.

       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
       0100-PRINCIPAL SECTION.
      * EXECUTA A ROTINA DE LEITURA INICIAL
           PERFORM 0200-LER-DADOS.
      * PROCESSA OS DADOS ATE QUE O USUARIO DIGITE 'F'
           PERFORM 0300-PROCESSAR UNTIL FIM-PROCESSAMENTO.
      * EXECUTA A ROTINA FINAL
           PERFORM 0400-FINALIZAR.
      * ENCERRA O PROGRAMA
           STOP RUN.
       0100-FIM. EXIT.

      *-----------------------------------------------------------------
       0200-LER-DADOS SECTION.
      * ZERA AS VARIAVEIS ANTES DE CADA LEITURA
           INITIALIZE WRK-DADOS-CLIENTE
                      WRK-DADOS-EDICAO.

           DISPLAY "-----------------------------------------".
           DISPLAY "Digite o tipo de conta (C/P) ou 'F' para sair: ".
           ACCEPT WRK-TIPO-CONTA.

      * CONVERTE A ENTRADA PARA MAIUSCULA PARA FACILITAR A VALIDACAO
           INSPECT WRK-TIPO-CONTA CONVERTING
                   'abcdefghijklmnopqrstuvwxyz' TO
                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.

      * SO PEDE OS OUTROS DADOS SE O USUARIO NAO QUISER SAIR
           IF NOT FIM-PROCESSAMENTO
              DISPLAY "Digite o nome do cliente: "
              ACCEPT WRK-NOME
              DISPLAY "Digite o saldo do cliente (ex: 1234,50): "
              ACCEPT WRK-SALDO
           END-IF.
       0200-FIM. EXIT.

      *-----------------------------------------------------------------
       0300-PROCESSAR SECTION.
      * INCREMENTA O CONTADOR PARA CADA REGISTRO PROCESSADO
           ADD 1 TO WRK-CONTADOR.

           IF WRK-SALDO >= 1000 AND TIPO-VALIDO
      * PROCESSAMENTO PARA CONTA VALIDA E SALDO SUFICIENTE
              MOVE WRK-SALDO TO WRK-SALDO-ED
              DISPLAY "Cliente: " WRK-NOME
              DISPLAY "Saldo Aprovado: " WRK-SALDO-ED
           ELSE
      * TRATAMENTO DE ERROS COM EVALUATE
              EVALUATE TRUE
                 WHEN WRK-SALDO < 1000
                    DISPLAY "ERRO: Saldo insuficiente para operacoes."
                 WHEN NOT TIPO-VALIDO
                    DISPLAY "ERRO: Tipo de conta invalido."
                 WHEN OTHER
                    DISPLAY "ERRO: Ocorreu um erro desconhecido."
              END-EVALUATE
           END-IF.

      * LE OS DADOS PARA A PROXIMA ITERACAO DO LOOP
           PERFORM 0200-LER-DADOS.
       0300-FIM. EXIT.

      *-----------------------------------------------------------------
       0400-FINALIZAR SECTION.
           DISPLAY "=================================".
           DISPLAY "     ESTATISTICAS FINAIS".
           DISPLAY "=================================".
           DISPLAY "Total de contas processadas: " WRK-CONTADOR.
           DISPLAY "=================================".
           DISPLAY "Fim do processamento.".
       0400-FIM. EXIT.