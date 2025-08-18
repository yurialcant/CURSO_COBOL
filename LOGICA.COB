       identification division.
       program-id. CLIENTES.
      *       environment division.
       environment division.
       configuration section.
       special-names.
           decimal-point is comma.

       data division.
       working-storage section.
       01  WRK-NOME    picture x(20) value spaces.
       01  WRK-SALDO   picture S9(10) comp value zeros.
       01  WRK-SALDO-ED picture Z.ZZZ.ZZZ.ZZ9,99.
       01  WRK-TIPO-CONTA picture x value spaces.
       01  WRK-CONTADOR picture 9(03) usage comp.


       procedure division.
       0100-PRINCIPAL section.

           perform 0200-INICIAR.
           perform 0300-PROCESSAR varying WRK-CONTADOR
                                  from 0 by 1 
                                  until WRK-TIPO-CONTA equal "C"
           perform 0400-FINALIZAR.
           stop run.

           
       
       0100-FIM. exit.
      
      *-------------INICIAR
       0200-INICIAR section.

           display "Digite o nome do cliente: ".
               accept WRK-NOME.
           
           display "Digite o saldo do cliente: ".
               accept WRK-SALDO.
           display "Digite o tipo de conta (C/P): ".
               accept WRK-TIPO-CONTA.

       0200-FIM. exit.
      
      
      *-------------PROCESSAR
       0300-PROCESSAR section.

           if WRK-SALDO greater than or equal 1000 and
              (WRK-TIPO-CONTA equal "C" OR  WRK-TIPO-CONTA equal "P")   
               display WRK-NOME
               move WRK-SALDO to WRK-SALDO-ED
               display "SALDO " WRK-SALDO-ED
           else
               evaluate true
                     when WRK-SALDO less than 1000
                          display "Saldo insuficiente para operações."
                     when WRK-TIPO-CONTA not equal "C" or
                          WRK-TIPO-CONTA not equal "P"
                          display "Tipo de conta inválido."
                     when other
                          display "Erro desconhecido."
                end-evaluate
           end-if.

           perform 0200-INICIAR.

       0300-FIM. exit.

      
      *-------------FINALIZAR
       0400-FINALIZAR section.

           display "-------------------------".
           display "ESTATISTICA".
           display "contas processadas: " WRK-CONTADOR.
           display "-------------------------".

       0400-FIM. exit.

