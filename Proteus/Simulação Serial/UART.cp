#line 1 "G:/IHM para Microcontroladores/Proteus/Simulação Serial/UART.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 24 "G:/IHM para Microcontroladores/Proteus/Simulação Serial/UART.c"
char uart_rd, D1, D2, D3, D4;
unsigned int Adc_rd;

void main()
{
 ADCON1 |= 0x0c;
 TRISA2_bit = 1;
 TRISA = 0xFF;

 TRISC.f0 = 1;
 TRISC.f1 = 1;
 TRISD = 0x00;
 PORTD = 0x00;
 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Conectou");
 UART1_Write(13);
 UART1_Write(10);
 UART1_Write_Text("Sim, perfeitamente");
 UART1_Write(13);
 UART1_Write(10);

 Portd = 0xff;

while (1)
 {

 if (~RC0_bit)
 {
 if (UART1_Data_Ready())

 {
 uart_rd = UART1_Read();
 UART1_Write(uart_rd);



 if (uart_rd == 48)
 {
 PORTD = 0x01;


 }

 if (uart_rd == 49)
 {
 PORTD = 0x02;


 }

 if (uart_rd == 50)
 {
 PORTD = 0x04;


 }

 if (uart_rd == 51)
 {
 PORTD = 0x08;


 }
 if (uart_rd == 52)
 {
 PORTD = 0x10;


 }

 if (uart_rd == 53)
 {
 PORTD = 0x20;


 }
 if (uart_rd == 54)
 {
 PORTD = 0x40;


 }

 if (uart_rd == 55)
 {
 PORTD = 0x80;


 }

 if (uart_rd == 76)
 {
 PORTD = 0xFF;


 }
 if (uart_rd == 68)
 {
 PORTD = 0x00;


 }

 if (uart_rd == 73)
 {
 PORTD = ~PORTD;


 }
 if (uart_rd == 65)
 {
 PORTD = 0xAA;


 }

 if (uart_rd == 69)
 {
 PORTD = 0x55;


 }

 delay_ms(500);
 }

 if (RC2_bit)
 {

 UART1_Write_Text("ti.txt=");
 UART1_Write_Text("\"");
 UART1_Write_Text("Nextion");
 UART1_Write_Text("\"");



 uart1_write_text("ÿÿÿ");




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



 uart1_write_text("ÿÿÿ");



 delay_ms(1000);
 }

 if (RC1_bit)
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

 Adc_rd = ADC_Read(2);
 D1 = Adc_rd / 1000;
 D2 = (Adc_rd - D1*1000) / 100;
 D3 = (Adc_rd - D1*1000 - D2*100) / 10;
 D4 = (Adc_rd - D1*1000 - D2*100 - D3*10);

 uart1_write_text("A");
 UART1_Write(48+D1);
 UART1_Write(48+D2);
 UART1_Write(48+D3);
 UART1_Write(48+D4);

 uart1_Write_text(" ");

 delay_ms(1000);
 }
 }
 }
}
