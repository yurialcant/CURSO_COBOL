       identification division.
       program-id. LEITORARQ.
      * LEITURA DE ARQUIVO
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EARQCLI ASSIGN TO ".\EARQCLI.TXT"
               FILE STATUS IS FS-EARQCLI.
           SELECT SARQCLI ASSIGN TO ".\SARQCLI.TXT"
               FILE STATUS IS FS-SARQCLI.

       data division.
       FILE SECTION.
       FD  EARQCLI
           recording mode is F.
           copy "BOOKCLI".
           
       FD  SARQCLI
           recording mode is F.
      *------Layout de 22 Posicoes para o arquivo de saida
       01  REG-SARQCLI     PICTURE X(22).
           
              
       working-storage section.
      *---------Variaveis de status do arquivo------------- 
       01  FS-EARQCLI     picture 9(02).
       01  FS-SARQCLI     picture 9(02).

      *-------VARIAVEIS ACUMULADORAS---------------- 
       01  WRK-CONTADOR       picture 9(03) usage comp.
       01  WRK-CONTADOR-VALIDO picture 9(03) usage comp.

       01  WRK-CONTADOR-NVALIDO picture 9(03) usage comp.

       
       procedure division.
       0100-PRINCIPAL SECTION.
           display "Iniciando a leitura do arquivo...".
           perform 0200-LER-DADOS.
           perform 0300-PROCESSAR until FS-EARQCLI equal 10.
           perform 0400-FINALIZAR.
           stop run.
       0100-FIM. EXIT.

      *------------------Leitura de Dados------------------- 

       0200-LER-DADOS SECTION.
           open input EARQCLI.
           open output SARQCLI.

           IF FS-EARQCLI not equal zeros and
              FS-SARQCLI not equal zeros
              display "ARQUIVO(S) NAO ABERTO(S)"
              goback
           END-IF.

           perform 0210-LEITURA.

       0200-FIM. EXIT.

      *------------------Leitura de Registro-------------------
       0210-LEITURA section.
           READ EARQCLI. 
       0210-FIM. EXIT.

      *------------------Processamento de Dados-------------------

       0300-PROCESSAR SECTION.
           
           add 1 to WRK-CONTADOR.
           
           IF REG-SALDO greater than or equal 5000 and
              (REG-TIPO-CONTA EQUAL 1 OR REG-TIPO-CONTA EQUAL 2)
               
              string REG-AGENCIA     DELIMITED BY size
                     REG-CONTA       DELIMITED BY size  
                     REG-TIPO-CONTA  DELIMITED BY size
                     REG-SALDO       DELIMITED BY size
                into REG-SARQCLI
                write REG-SARQCLI
                 if FS-SARQCLI not equal zeros
                    display "ERRO AO GRAVAR: " REG-AGENCIA REG-CONTA
                 end-if
                
              add 1 to WRK-CONTADOR-VALIDO

           else
              add 1 to WRK-CONTADOR-NVALIDO
           END-IF.

              perform 0210-LEITURA.


       0300-FIM. EXIT.

      *------------------Finalização do Programa------------------- 

       0400-FINALIZAR SECTION.

           close EARQCLI.
           close SARQCLI.

           display "Finalizando o programa...".
           display "CLIENTES LIDOS: " WRK-CONTADOR.
           display "VALIDOS........ " WRK-CONTADOR-VALIDO.
           display "INVALIDOS...... " WRK-CONTADOR-NVALIDO.

       0400-FIM. EXIT.

       