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
       01  WRK-SALDO   picture S9(10) value zeros.
       01  WRK-SALDO-ED picture Z.ZZZ.ZZZ.ZZ9,99.

       procedure division.

           display "Digite o nome do cliente: ".
               accept WRK-NOME.
           
           display "Digite o saldo do cliente: ".
               accept WRK-SALDO.

           display WRK-NOME.
      *-------- Operações com o saldo do cliente         
           add 1000 to WRK-SALDO.
           
               move WRK-SALDO to WRK-SALDO-ED
           display "SALDO " WRK-SALDO-ED.
           display "------------------------".

           subtract 500 from WRK-SALDO.
               move WRK-SALDO to WRK-SALDO-ED
           display "SALDO " WRK-SALDO-ED.
           display "------------------------".

           multiply WRK-SALDO by 8 giving WRK-SALDO.
               move WRK-SALDO to WRK-SALDO-ED
           display "SALDO " WRK-SALDO-ED.
           display "------------------------".

           divide WRK-SALDO by 2 giving WRK-SALDO
               move WRK-SALDO to WRK-SALDO-ED
           display "SALDO " WRK-SALDO-ED.
           
           stop run.