/*
 * Project name:
     IHM para Microcontroladores - UART
 * Copyright:
     (c) IFMG CAMPUS BETIM, 2022.
     Helbert de Sá
 * Revisão Histórica:
     20220619:
       - Versão 2;
 * Descrição:
     Esta aplicação irá explicar  o funcionamento da UART e conexão com uma IHM.

 * Hardware configuração:
     MCU:             PIC16F887
     Oscilador:       16.0000 MHz
     Ext. Modules:    -
     SW:              mikroC PRO for PIC v7.6.0
 * NOTAS:
     - Verificar simulações em PROTEUS/ISIS
*/
         
#include <built_in.h>             // biblioteca para numeros analogicos

char uart_rd, D1, D2, D3, D4;
unsigned int  Adc_rd;            // leitura do pino analogico
     
void main() 
{
  ADCON1 |= 0x0c;                     // Seta o canal pino AN2 como analógico
  TRISA2_bit = 1;                     // Entrada
  TRISA = 0xFF;                       //   input
  
  TRISC.f0 = 1;
  TRISC.f1 = 1;
  TRISD = 0x00; 
  PORTD = 0x00;
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Conectou");
  UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
  UART1_Write(10);
  UART1_Write_Text("Sim, perfeitamente");
  UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
  UART1_Write(10);
  
  Portd = 0xff;           // Inicializa o PORTD ligado
  
while (1)
  {
     // Permite que a informação digitada no Terminal TX envie para Microcontrolador e processe para o RX
  if (~RC0_bit)                 // Tecla 3 do teclado pois 49 é o seu ASCII  troca texto no NEXTION
   {
    if (UART1_Data_Ready())

       {                             // If data is received,
         uart_rd = UART1_Read();     // read the received data,
         UART1_Write(uart_rd);       // and send data via UART
    //     UART1_Write(13);            // Comando que pula a linha e visualiza no virtual terminal
    //     UART1_Write(10);
      
         if (uart_rd == 48)           // Tecla 0 do teclado pois 48 é o seu ASCII
          {
           PORTD = 0x01;              // Ligou PortD0
     //      UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }
      
         if (uart_rd == 49)           // Tecla 1 do teclado pois 49 é o seu ASCII
          {
           PORTD = 0x02;              // Desligou PortD1
    //       UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
   //        UART1_Write(10);
          }

         if (uart_rd == 50)           // Tecla 2 do teclado pois 50 é o seu ASCII
          {
           PORTD = 0x04;              // Ligou PortD2
      //     UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }

         if (uart_rd == 51)           // Tecla 3 do teclado pois 51 é o seu ASCII
          {
           PORTD = 0x08;              // Desligou PortD3
      //     UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }
         if (uart_rd == 52)           // Tecla 4 do teclado pois 52 é o seu ASCII
          {
           PORTD = 0x10;              // Ligou PortD4
      //     UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }

         if (uart_rd == 53)           // Tecla 5 do teclado pois 53 é o seu ASCII
          {
           PORTD = 0x20;              // Desligou PortD
      //     UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }
         if (uart_rd == 54)           // Tecla 6 do teclado pois 54 é o seu ASCII
          {
           PORTD = 0x40;              // Ligou PortD
      //     UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }

         if (uart_rd == 55)           // Tecla 7 do teclado pois 55 é o seu ASCII
          {
           PORTD = 0x80;              // Desligou PortD
       //    UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
      //     UART1_Write(10);
          }

         if (uart_rd == 76)           // Tecla L do teclado pois 76 é o seu ASCII
          {
           PORTD = 0xFF;              // Desligou PortD
    //       UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
    //       UART1_Write(10);
          }
         if (uart_rd == 68)           // Tecla D do teclado pois 68 é o seu ASCII
          {
           PORTD = 0x00;              // Ligou PortD
     //      UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }

         if (uart_rd == 73)           // Tecla I do teclado pois 73 é o seu ASCII
          {
           PORTD = ~PORTD;            // Desligou PortD
     //      UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }
         if (uart_rd == 65)           // Tecla A do teclado pois 65 é o seu ASCII
          {
           PORTD = 0xAA;              // Ligou PortD
          // UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
    //       UART1_Write(10);
          }

         if (uart_rd == 69)           // Tecla E do teclado pois 69 é o seu ASCII
          {
           PORTD = 0x55;              // Desligou PortD
      //     UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
     //      UART1_Write(10);
          }

         delay_ms(500);
        }  // Fim  do IF UART1_Data_Ready()

    if (RC2_bit)
        {
        //  troca texto no NEXTION
          UART1_Write_Text("ti.txt=");
          UART1_Write_Text("\"");
          UART1_Write_Text("Nextion");
          UART1_Write_Text("\"");
       //   UART1_Write(0xff);
      //    UART1_Write(0xff);
      //    UART1_Write(0xff);
          uart1_write_text("ÿÿÿ");
   //       UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
   //     UART1_Write(10);
   
                  //  troca texto no NEXTION
          UART1_Write_Text("d0.txt=");
          UART1_Write_Text("\"");
          uart1_Write(48+PORTD.f0);
          uart1_Write(48+PORTD.f1);
          uart1_Write(48+PORTD.f2);
          uart1_Write(48+PORTD.f3);
          uart1_Write(48+PORTD.f4);
          uart1_Write(48+PORTD.f5);
          uart1_Write(48+PORTD.f6);
          uart1_Write(48+PORTD.f7);
          UART1_Write_Text("\"");
       //   UART1_Write(0xff);
      //    UART1_Write(0xff);
      //    UART1_Write(0xff);
          uart1_write_text("ÿÿÿ");
   //       UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
   //     UART1_Write(10);
   
                          delay_ms(1000);
        }
        
    if (RC1_bit)                 // Tecla 3 do teclado pois 49 é o seu ASCII  troca texto no NEXTION
        {
          uart1_write_text("D");
          
          uart1_Write(48+PORTD.f0);
          uart1_Write(48+PORTD.f1);
          uart1_Write(48+PORTD.f2);
          uart1_Write(48+PORTD.f3);
          uart1_Write(48+PORTD.f4);
          uart1_Write(48+PORTD.f5);
          uart1_Write(48+PORTD.f6);
          uart1_Write(48+PORTD.f7);
          
          uart1_Write_text(" ");
        
          Adc_rd = ADC_Read(2);            // Lê o valor de tensão em AN2  de 0 a 1023 total 1024
          D1 = Adc_rd / 1000;                         // MSD digit Milhar
          D2 = (Adc_rd - D1*1000) / 100;              //   digit Centena
          D3 = (Adc_rd - D1*1000 - D2*100) / 10;      //   digit Dezena
          D4 = (Adc_rd - D1*1000 - D2*100 - D3*10);   // LSD digit Unidade

          uart1_write_text("A");
          UART1_Write(48+D1);
          UART1_Write(48+D2);
          UART1_Write(48+D3);
          UART1_Write(48+D4);
                              
          uart1_Write_text(" ");

          delay_ms(1000);
        }
  }        // Fim do loop infinito
 }
}