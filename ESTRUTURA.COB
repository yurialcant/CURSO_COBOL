       IDENTIFICATION DIVISION.  
       PROGRAM-ID. ATIVIDADE09.  
       
       DATA DIVISION.  
       WORKING-STORAGE SECTION.  
       
       01 CLIENTE.  
          05 ENDERECO.  
             10 RUA    PIC X(30).  
             10 NUMERO PIC 9(3).  
             10 CEP    PIC 9(8).  
       
       PROCEDURE DIVISION.  
           MOVE "AVENIDA CENTRAL" TO RUA OF ENDERECO OF CLIENTE.  
           MOVE 145 TO NUMERO OF ENDERECO OF CLIENTE.  
           MOVE 12345678 TO CEP OF ENDERECO OF CLIENTE.  
       
           DISPLAY "RUA: " RUA OF ENDERECO OF CLIENTE.  
           DISPLAY "NÚMERO: " NUMERO OF ENDERECO OF CLIENTE.  
           DISPLAY "CEP: " CEP OF ENDERECO OF CLIENTE.  
       
           STOP RUN.  
       