       identification division.
       program-id. VARIAVEIS.
     
       environment division.
       
       configuration section.
       
       special-names.
           decimal-point is comma.
       
       data division.
       
       working-storage section.

       01  REGISTRO.
           05 REG-AGENCIA     PIC X(04) VALUE spaces.
           05 REG-CONTA       PIC X(05) VALUE spaces.
           05 REG-NOME        PIC X(30) VALUE spaces.
           05 REG-GERENTE     PIC X(03) VALUE spaces.
           05 REG-SALDO       PIC 9(10)V99.
           05 REG-TIPO-CONTA  PIC 9(01).
       01  WRK-CONTADOR       PIC 9(03) USAGE COMP.

       procedure division.
       0100-PRINCIPAL SECTION.
           display "Iniciando o processamento de contas...".
           perform 0200-LER-DADOS.
           perform 0300-PROCESSAR.
           perform 0400-FINALIZAR.
           stop run.
       0100-FIM. EXIT.

      *-----------------------------------------------------------------
       0200-LER-DADOS SECTION.
           display "-----------------------------------------".
           display "Digite a agência: ".
           accept REG-AGENCIA.
           display "Digite o número da conta: ".
           accept REG-CONTA.
           display "Digite o nome do cliente: ".
           accept REG-NOME.
           display "Digite o gerente da conta: ".
           accept REG-GERENTE.
           display "Digite o saldo da conta (ex: 12345678,90): ".
           accept REG-SALDO.
           display "Digite o tipo de conta (1/2) ou '0' para sair: ".
           accept REG-TIPO-CONTA.

       0200-FIM. EXIT.

      *----------------------------------------------------------------- 
       
       0300-PROCESSAR SECTION.
           IF REG-SALDO GREATER THAN OR EQUAL 5000 and
              (REG-TIPO-CONTA EQUAL 1 OR REG-TIPO-CONTA EQUAL 2)
               DISPLAY REGISTRO
           ELSE
                EVALUATE TRUE
                     WHEN REG-SALDO LESS THAN 5000
                          DISPLAY "Saldo insuficiente para operações."
                     WHEN REG-TIPO-CONTA NOT EQUAL 1 AND
                            REG-TIPO-CONTA NOT EQUAL 2
                          DISPLAY "Tipo de conta inválido."
                END-EVALUATE
           END-IF.   
       0300-FIM. EXIT.


      
      *-----------------------------------------------------------------
       0400-FINALIZAR SECTION.
           display "Total de contas processadas: " WRK-CONTADOR.
           display "Processamento finalizado.".
       0400-FIM. EXIT.