
_main:

;UART.c,27 :: 		void main()
;UART.c,29 :: 		ADCON1 |= 0x0c;                     // Seta o canal pino AN2 como analógico
	MOVLW      12
	IORWF      ADCON1+0, 1
;UART.c,30 :: 		TRISA2_bit = 1;                     // Entrada
	BSF        TRISA2_bit+0, BitPos(TRISA2_bit+0)
;UART.c,31 :: 		TRISA = 0xFF;                       //   input
	MOVLW      255
	MOVWF      TRISA+0
;UART.c,33 :: 		TRISC.f0 = 1;
	BSF        TRISC+0, 0
;UART.c,34 :: 		TRISC.f1 = 1;
	BSF        TRISC+0, 1
;UART.c,35 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;UART.c,36 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;UART.c,37 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;UART.c,38 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
;UART.c,40 :: 		UART1_Write_Text("Conectou");
	MOVLW      ?lstr1_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,41 :: 		UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,42 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,43 :: 		UART1_Write_Text("Sim, perfeitamente");
	MOVLW      ?lstr2_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,44 :: 		UART1_Write(13);           // Comando que pula a linha e visualiza no virtual terminal
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,45 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,47 :: 		Portd = 0xff;
	MOVLW      255
	MOVWF      PORTD+0
;UART.c,49 :: 		while (1)
L_main1:
;UART.c,52 :: 		if (~RC0_bit)                 // Tecla 3 do teclado pois 49 é o seu ASCII  troca texto no NEXTION
	BTFSC      RC0_bit+0, BitPos(RC0_bit+0)
	GOTO       L__main24
	BSF        3, 0
	GOTO       L__main25
L__main24:
	BCF        3, 0
L__main25:
	BTFSS      3, 0
	GOTO       L_main3
;UART.c,54 :: 		if (UART1_Data_Ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;UART.c,57 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;UART.c,58 :: 		UART1_Write(uart_rd);       // and send data via UART
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,62 :: 		if (uart_rd == 48)           // Tecla 0 do teclado pois 48 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;UART.c,64 :: 		PORTD = 0x01;              // Ligou PortD0
	MOVLW      1
	MOVWF      PORTD+0
;UART.c,67 :: 		}
L_main5:
;UART.c,69 :: 		if (uart_rd == 49)           // Tecla 1 do teclado pois 49 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;UART.c,71 :: 		PORTD = 0x02;              // Desligou PortD1
	MOVLW      2
	MOVWF      PORTD+0
;UART.c,74 :: 		}
L_main6:
;UART.c,76 :: 		if (uart_rd == 50)           // Tecla 2 do teclado pois 50 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;UART.c,78 :: 		PORTD = 0x04;              // Ligou PortD2
	MOVLW      4
	MOVWF      PORTD+0
;UART.c,81 :: 		}
L_main7:
;UART.c,83 :: 		if (uart_rd == 51)           // Tecla 3 do teclado pois 51 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;UART.c,85 :: 		PORTD = 0x08;              // Desligou PortD3
	MOVLW      8
	MOVWF      PORTD+0
;UART.c,88 :: 		}
L_main8:
;UART.c,89 :: 		if (uart_rd == 52)           // Tecla 4 do teclado pois 52 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;UART.c,91 :: 		PORTD = 0x10;              // Ligou PortD4
	MOVLW      16
	MOVWF      PORTD+0
;UART.c,94 :: 		}
L_main9:
;UART.c,96 :: 		if (uart_rd == 53)           // Tecla 5 do teclado pois 53 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;UART.c,98 :: 		PORTD = 0x20;              // Desligou PortD
	MOVLW      32
	MOVWF      PORTD+0
;UART.c,101 :: 		}
L_main10:
;UART.c,102 :: 		if (uart_rd == 54)           // Tecla 6 do teclado pois 54 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      54
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;UART.c,104 :: 		PORTD = 0x40;              // Ligou PortD
	MOVLW      64
	MOVWF      PORTD+0
;UART.c,107 :: 		}
L_main11:
;UART.c,109 :: 		if (uart_rd == 55)           // Tecla 7 do teclado pois 55 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      55
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;UART.c,111 :: 		PORTD = 0x80;              // Desligou PortD
	MOVLW      128
	MOVWF      PORTD+0
;UART.c,114 :: 		}
L_main12:
;UART.c,116 :: 		if (uart_rd == 76)           // Tecla L do teclado pois 76 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      76
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;UART.c,118 :: 		PORTD = 0xFF;              // Desligou PortD
	MOVLW      255
	MOVWF      PORTD+0
;UART.c,121 :: 		}
L_main13:
;UART.c,122 :: 		if (uart_rd == 68)           // Tecla D do teclado pois 68 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;UART.c,124 :: 		PORTD = 0x00;              // Ligou PortD
	CLRF       PORTD+0
;UART.c,127 :: 		}
L_main14:
;UART.c,129 :: 		if (uart_rd == 73)           // Tecla I do teclado pois 73 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      73
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;UART.c,131 :: 		PORTD = ~PORTD;            // Desligou PortD
	COMF       PORTD+0, 1
;UART.c,134 :: 		}
L_main15:
;UART.c,135 :: 		if (uart_rd == 65)           // Tecla A do teclado pois 65 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;UART.c,137 :: 		PORTD = 0xAA;              // Ligou PortD
	MOVLW      170
	MOVWF      PORTD+0
;UART.c,140 :: 		}
L_main16:
;UART.c,142 :: 		if (uart_rd == 69)           // Tecla E do teclado pois 69 é o seu ASCII
	MOVF       _uart_rd+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;UART.c,144 :: 		PORTD = 0x55;              // Desligou PortD
	MOVLW      85
	MOVWF      PORTD+0
;UART.c,147 :: 		}
L_main17:
;UART.c,149 :: 		delay_ms(500);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
	NOP
;UART.c,150 :: 		}  // Fim  do IF UART1_Data_Ready()
L_main4:
;UART.c,152 :: 		if (RC2_bit)
	BTFSS      RC2_bit+0, BitPos(RC2_bit+0)
	GOTO       L_main19
;UART.c,155 :: 		UART1_Write_Text("ti.txt=");
	MOVLW      ?lstr3_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,156 :: 		UART1_Write_Text("\"");
	MOVLW      ?lstr4_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,157 :: 		UART1_Write_Text("Nextion");
	MOVLW      ?lstr5_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,158 :: 		UART1_Write_Text("\"");
	MOVLW      ?lstr6_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,162 :: 		uart1_write_text("ÿÿÿ");
	MOVLW      ?lstr7_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,167 :: 		UART1_Write_Text("d0.txt=");
	MOVLW      ?lstr8_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,168 :: 		UART1_Write_Text("\"");
	MOVLW      ?lstr9_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,169 :: 		uart1_Write(48+PORTD.f0);
	CLRF       R0+0
	BTFSC      PORTD+0, 0
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,170 :: 		uart1_Write(48+PORTD.f1);
	CLRF       R0+0
	BTFSC      PORTD+0, 1
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,171 :: 		uart1_Write(48+PORTD.f2);
	CLRF       R0+0
	BTFSC      PORTD+0, 2
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,172 :: 		uart1_Write(48+PORTD.f3);
	CLRF       R0+0
	BTFSC      PORTD+0, 3
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,173 :: 		uart1_Write(48+PORTD.f4);
	CLRF       R0+0
	BTFSC      PORTD+0, 4
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,174 :: 		uart1_Write(48+PORTD.f5);
	CLRF       R0+0
	BTFSC      PORTD+0, 5
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,175 :: 		uart1_Write(48+PORTD.f6);
	CLRF       R0+0
	BTFSC      PORTD+0, 6
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,176 :: 		uart1_Write(48+PORTD.f7);
	CLRF       R0+0
	BTFSC      PORTD+0, 7
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,177 :: 		UART1_Write_Text("\"");
	MOVLW      ?lstr10_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,181 :: 		uart1_write_text("ÿÿÿ");
	MOVLW      ?lstr11_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,185 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
;UART.c,186 :: 		}
L_main19:
;UART.c,188 :: 		if (RC1_bit)                 // Tecla 3 do teclado pois 49 é o seu ASCII  troca texto no NEXTION
	BTFSS      RC1_bit+0, BitPos(RC1_bit+0)
	GOTO       L_main21
;UART.c,190 :: 		uart1_write_text("D");
	MOVLW      ?lstr12_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,192 :: 		uart1_Write(48+PORTD.f0);
	CLRF       R0+0
	BTFSC      PORTD+0, 0
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,193 :: 		uart1_Write(48+PORTD.f1);
	CLRF       R0+0
	BTFSC      PORTD+0, 1
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,194 :: 		uart1_Write(48+PORTD.f2);
	CLRF       R0+0
	BTFSC      PORTD+0, 2
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,195 :: 		uart1_Write(48+PORTD.f3);
	CLRF       R0+0
	BTFSC      PORTD+0, 3
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,196 :: 		uart1_Write(48+PORTD.f4);
	CLRF       R0+0
	BTFSC      PORTD+0, 4
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,197 :: 		uart1_Write(48+PORTD.f5);
	CLRF       R0+0
	BTFSC      PORTD+0, 5
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,198 :: 		uart1_Write(48+PORTD.f6);
	CLRF       R0+0
	BTFSC      PORTD+0, 6
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,199 :: 		uart1_Write(48+PORTD.f7);
	CLRF       R0+0
	BTFSC      PORTD+0, 7
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,201 :: 		uart1_Write_text(" ");
	MOVLW      ?lstr13_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,203 :: 		Adc_rd = ADC_Read(2);            // Lê o valor de tensão em AN2  de 0 a 1023 total 1024
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+6
	MOVF       R0+1, 0
	MOVWF      FLOC__main+7
	MOVF       FLOC__main+6, 0
	MOVWF      _Adc_rd+0
	MOVF       FLOC__main+7, 0
	MOVWF      _Adc_rd+1
;UART.c,204 :: 		D1 = Adc_rd / 1000;                         // MSD digit Milhar
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       FLOC__main+6, 0
	MOVWF      R0+0
	MOVF       FLOC__main+7, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _D1+0
;UART.c,205 :: 		D2 = (Adc_rd - D1*1000) / 100;              //   digit Centena
	MOVLW      0
	MOVWF      R0+1
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+4
	MOVF       R0+1, 0
	MOVWF      FLOC__main+5
	MOVF       FLOC__main+4, 0
	SUBWF      FLOC__main+6, 0
	MOVWF      R0+0
	MOVF       FLOC__main+5, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+7, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _D2+0
;UART.c,206 :: 		D3 = (Adc_rd - D1*1000 - D2*100) / 10;      //   digit Dezena
	MOVF       FLOC__main+4, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	SUBWF      FLOC__main+6, 0
	MOVWF      FLOC__main+2
	MOVF       R2+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+7, 0
	MOVWF      FLOC__main+3
	MOVLW      100
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       FLOC__main+0, 0
	SUBWF      FLOC__main+2, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+3, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _D3+0
;UART.c,207 :: 		D4 = (Adc_rd - D1*1000 - D2*100 - D3*10);   // LSD digit Unidade
	MOVF       FLOC__main+4, 0
	SUBWF      FLOC__main+6, 0
	MOVWF      _D4+0
	MOVF       FLOC__main+0, 0
	SUBWF      _D4+0, 1
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	SUBWF      _D4+0, 1
;UART.c,209 :: 		uart1_write_text("A");
	MOVLW      ?lstr14_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,210 :: 		UART1_Write(48+D1);
	MOVF       _D1+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,211 :: 		UART1_Write(48+D2);
	MOVF       _D2+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,212 :: 		UART1_Write(48+D3);
	MOVF       _D3+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,213 :: 		UART1_Write(48+D4);
	MOVF       _D4+0, 0
	ADDLW      48
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UART.c,215 :: 		uart1_Write_text(" ");
	MOVLW      ?lstr15_UART+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UART.c,217 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
	NOP
;UART.c,218 :: 		}
L_main21:
;UART.c,219 :: 		}        // Fim do loop infinito
L_main3:
;UART.c,220 :: 		}
	GOTO       L_main1
;UART.c,221 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
