-----------------------------------------------------------------------
--
-- Copyright (C) 2014 Ali Paikan (ali.paikan@gmail.com).  
--
--   Redistribution and use in source and binary forms, with or without
--   modification, are permitted provided that the following conditions
--   are met:
-- 
--   Redistributions of source code must retain the above copyright
--   notice, this list of conditions and the following disclaimer.
-- 
--   Redistributions in binary form must reproduce the above copyright
--   notice, this list of conditions and the following disclaimer in the
--   documentation and/or other materials provided with the  
--   distribution.
-- 
--   Neither the name of Texas Instruments Incorporated nor the names of
--   its contributors may be used to endorse or promote products derived
--   from this software without specific prior written permission.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-- OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-- LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-- THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
-------------------------------------------------------------------------


pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package LM4F120.Sysctl is

   SYSCTL_PERIPH_WDOG0 : constant := 16#00000008#;  --  lm4f120/sysctl.h:68
   SYSCTL_PERIPH_HIBERNATE : constant := 16#00000040#;  --  lm4f120/sysctl.h:69

   SYSCTL_PERIPH_ADC0 : constant := 16#00100001#;  --  lm4f120/sysctl.h:73
   SYSCTL_PERIPH_ADC1 : constant := 16#00100002#;  --  lm4f120/sysctl.h:74

   SYSCTL_PERIPH_PWM0 : constant := 16#00100010#;  --  lm4f120/sysctl.h:78
   SYSCTL_PERIPH_CAN0 : constant := 16#00100100#;  --  lm4f120/sysctl.h:79
   SYSCTL_PERIPH_CAN1 : constant := 16#00100200#;  --  lm4f120/sysctl.h:80
   SYSCTL_PERIPH_CAN2 : constant := 16#00100400#;  --  lm4f120/sysctl.h:81
   SYSCTL_PERIPH_WDOG1 : constant := 16#00101000#;  --  lm4f120/sysctl.h:82
   SYSCTL_PERIPH_UART0 : constant := 16#10000001#;  --  lm4f120/sysctl.h:83
   SYSCTL_PERIPH_UART1 : constant := 16#10000002#;  --  lm4f120/sysctl.h:84
   SYSCTL_PERIPH_UART2 : constant := 16#10000004#;  --  lm4f120/sysctl.h:85

   SYSCTL_PERIPH_SSI0 : constant := 16#10000010#;  --  lm4f120/sysctl.h:89
   SYSCTL_PERIPH_SSI1 : constant := 16#10000020#;  --  lm4f120/sysctl.h:90

   SYSCTL_PERIPH_QEI0 : constant := 16#10000100#;  --  lm4f120/sysctl.h:94
   SYSCTL_PERIPH_QEI1 : constant := 16#10000200#;  --  lm4f120/sysctl.h:95

   SYSCTL_PERIPH_I2C0 : constant := 16#10001000#;  --  lm4f120/sysctl.h:99
   SYSCTL_PERIPH_I2C1 : constant := 16#10004000#;  --  lm4f120/sysctl.h:100
   SYSCTL_PERIPH_TIMER0 : constant := 16#10100001#;  --  lm4f120/sysctl.h:101
   SYSCTL_PERIPH_TIMER1 : constant := 16#10100002#;  --  lm4f120/sysctl.h:102
   SYSCTL_PERIPH_TIMER2 : constant := 16#10100004#;  --  lm4f120/sysctl.h:103
   SYSCTL_PERIPH_TIMER3 : constant := 16#10100008#;  --  lm4f120/sysctl.h:104
   SYSCTL_PERIPH_COMP0 : constant := 16#10100100#;  --  lm4f120/sysctl.h:105
   SYSCTL_PERIPH_COMP1 : constant := 16#10100200#;  --  lm4f120/sysctl.h:106
   SYSCTL_PERIPH_COMP2 : constant := 16#10100400#;  --  lm4f120/sysctl.h:107
   SYSCTL_PERIPH_I2S0 : constant := 16#10101000#;  --  lm4f120/sysctl.h:108
   SYSCTL_PERIPH_EPI0 : constant := 16#10104000#;  --  lm4f120/sysctl.h:109
   SYSCTL_PERIPH_GPIOA : constant := 16#20000001#;  --  lm4f120/sysctl.h:110
   SYSCTL_PERIPH_GPIOB : constant := 16#20000002#;  --  lm4f120/sysctl.h:111
   SYSCTL_PERIPH_GPIOC : constant := 16#20000004#;  --  lm4f120/sysctl.h:112
   SYSCTL_PERIPH_GPIOD : constant := 16#20000008#;  --  lm4f120/sysctl.h:113
   SYSCTL_PERIPH_GPIOE : constant := 16#20000010#;  --  lm4f120/sysctl.h:114
   SYSCTL_PERIPH_GPIOF : constant := 16#20000020#;  --  lm4f120/sysctl.h:115
   SYSCTL_PERIPH_GPIOG : constant := 16#20000040#;  --  lm4f120/sysctl.h:116
   SYSCTL_PERIPH_GPIOH : constant := 16#20000080#;  --  lm4f120/sysctl.h:117
   SYSCTL_PERIPH_GPIOJ : constant := 16#20000100#;  --  lm4f120/sysctl.h:118
   SYSCTL_PERIPH_UDMA : constant := 16#20002000#;  --  lm4f120/sysctl.h:119
   SYSCTL_PERIPH_USB0 : constant := 16#20100001#;  --  lm4f120/sysctl.h:120
   SYSCTL_PERIPH_ETH : constant := 16#20105000#;  --  lm4f120/sysctl.h:121
   SYSCTL_PERIPH_IEEE1588 : constant := 16#20100100#;  --  lm4f120/sysctl.h:122
   SYSCTL_PERIPH_PLL : constant := 16#30000010#;  --  lm4f120/sysctl.h:123
   SYSCTL_PERIPH_TEMP : constant := 16#30000020#;  --  lm4f120/sysctl.h:124
   SYSCTL_PERIPH_MPU : constant := 16#30000080#;  --  lm4f120/sysctl.h:125
   SYSCTL_PERIPH2_ADC0 : constant := 16#f0003800#;  --  lm4f120/sysctl.h:126
   SYSCTL_PERIPH2_ADC1 : constant := 16#f0003801#;  --  lm4f120/sysctl.h:127
   SYSCTL_PERIPH2_CAN0 : constant := 16#f0003400#;  --  lm4f120/sysctl.h:128
   SYSCTL_PERIPH2_CAN1 : constant := 16#f0003401#;  --  lm4f120/sysctl.h:129
   SYSCTL_PERIPH2_CAN2 : constant := 16#f0003402#;  --  lm4f120/sysctl.h:130
   SYSCTL_PERIPH2_COMP0 : constant := 16#f0003c00#;  --  lm4f120/sysctl.h:131
   SYSCTL_PERIPH_EEPROM0 : constant := 16#f0005800#;  --  lm4f120/sysctl.h:132
   SYSCTL_PERIPH2_EPI0 : constant := 16#f0001000#;  --  lm4f120/sysctl.h:133
   SYSCTL_PERIPH2_ETH : constant := 16#f0002c00#;  --  lm4f120/sysctl.h:134
   SYSCTL_PERIPH_FAN0 : constant := 16#f0005400#;  --  lm4f120/sysctl.h:135
   SYSCTL_PERIPH2_GPIOA : constant := 16#f0000800#;  --  lm4f120/sysctl.h:136
   SYSCTL_PERIPH2_GPIOB : constant := 16#f0000801#;  --  lm4f120/sysctl.h:137
   SYSCTL_PERIPH2_GPIOC : constant := 16#f0000802#;  --  lm4f120/sysctl.h:138
   SYSCTL_PERIPH2_GPIOD : constant := 16#f0000803#;  --  lm4f120/sysctl.h:139
   SYSCTL_PERIPH2_GPIOE : constant := 16#f0000804#;  --  lm4f120/sysctl.h:140
   SYSCTL_PERIPH2_GPIOF : constant := 16#f0000805#;  --  lm4f120/sysctl.h:141
   SYSCTL_PERIPH2_GPIOG : constant := 16#f0000806#;  --  lm4f120/sysctl.h:142
   SYSCTL_PERIPH2_GPIOH : constant := 16#f0000807#;  --  lm4f120/sysctl.h:143
   SYSCTL_PERIPH2_GPIOJ : constant := 16#f0000808#;  --  lm4f120/sysctl.h:144
   SYSCTL_PERIPH_GPIOK : constant := 16#f0000809#;  --  lm4f120/sysctl.h:145
   SYSCTL_PERIPH_GPIOL : constant := 16#f000080a#;  --  lm4f120/sysctl.h:146
   SYSCTL_PERIPH_GPIOM : constant := 16#f000080b#;  --  lm4f120/sysctl.h:147
   SYSCTL_PERIPH_GPION : constant := 16#f000080c#;  --  lm4f120/sysctl.h:148
   SYSCTL_PERIPH_GPIOP : constant := 16#f000080d#;  --  lm4f120/sysctl.h:149
   SYSCTL_PERIPH_GPIOQ : constant := 16#f000080e#;  --  lm4f120/sysctl.h:150
   SYSCTL_PERIPH_GPIOR : constant := 16#f000080f#;  --  lm4f120/sysctl.h:151
   SYSCTL_PERIPH_GPIOS : constant := 16#f0000810#;  --  lm4f120/sysctl.h:152
   SYSCTL_PERIPH2_HIB : constant := 16#f0001400#;  --  lm4f120/sysctl.h:153
   SYSCTL_PERIPH2_I2C0 : constant := 16#f0002000#;  --  lm4f120/sysctl.h:154
   SYSCTL_PERIPH2_I2C1 : constant := 16#f0002001#;  --  lm4f120/sysctl.h:155
   SYSCTL_PERIPH_I2C2 : constant := 16#f0002002#;  --  lm4f120/sysctl.h:156
   SYSCTL_PERIPH_I2C3 : constant := 16#f0002003#;  --  lm4f120/sysctl.h:157
   SYSCTL_PERIPH_I2C4 : constant := 16#f0002004#;  --  lm4f120/sysctl.h:158
   SYSCTL_PERIPH_I2C5 : constant := 16#f0002005#;  --  lm4f120/sysctl.h:159
   SYSCTL_PERIPH2_I2S0 : constant := 16#f0002400#;  --  lm4f120/sysctl.h:160
   SYSCTL_PERIPH_LPC0 : constant := 16#f0004800#;  --  lm4f120/sysctl.h:161
   SYSCTL_PERIPH_PECI0 : constant := 16#f0005000#;  --  lm4f120/sysctl.h:162
   SYSCTL_PERIPH2_PWM0 : constant := 16#f0004000#;  --  lm4f120/sysctl.h:163
   SYSCTL_PERIPH_PWM1 : constant := 16#f0004001#;  --  lm4f120/sysctl.h:164
   SYSCTL_PERIPH2_QEI0 : constant := 16#f0004400#;  --  lm4f120/sysctl.h:165
   SYSCTL_PERIPH2_QEI1 : constant := 16#f0004401#;  --  lm4f120/sysctl.h:166
   SYSCTL_PERIPH2_SSI0 : constant := 16#f0001c00#;  --  lm4f120/sysctl.h:167
   SYSCTL_PERIPH2_SSI1 : constant := 16#f0001c01#;  --  lm4f120/sysctl.h:168
   SYSCTL_PERIPH_SSI2 : constant := 16#f0001c02#;  --  lm4f120/sysctl.h:169
   SYSCTL_PERIPH_SSI3 : constant := 16#f0001c03#;  --  lm4f120/sysctl.h:170
   SYSCTL_PERIPH2_TIMER0 : constant := 16#f0000400#;  --  lm4f120/sysctl.h:171
   SYSCTL_PERIPH2_TIMER1 : constant := 16#f0000401#;  --  lm4f120/sysctl.h:172
   SYSCTL_PERIPH2_TIMER2 : constant := 16#f0000402#;  --  lm4f120/sysctl.h:173
   SYSCTL_PERIPH2_TIMER3 : constant := 16#f0000403#;  --  lm4f120/sysctl.h:174
   SYSCTL_PERIPH_TIMER4 : constant := 16#f0000404#;  --  lm4f120/sysctl.h:175
   SYSCTL_PERIPH_TIMER5 : constant := 16#f0000405#;  --  lm4f120/sysctl.h:176
   SYSCTL_PERIPH_WTIMER0 : constant := 16#f0005c00#;  --  lm4f120/sysctl.h:177
   SYSCTL_PERIPH_WTIMER1 : constant := 16#f0005c01#;  --  lm4f120/sysctl.h:178
   SYSCTL_PERIPH_WTIMER2 : constant := 16#f0005c02#;  --  lm4f120/sysctl.h:179
   SYSCTL_PERIPH_WTIMER3 : constant := 16#f0005c03#;  --  lm4f120/sysctl.h:180
   SYSCTL_PERIPH_WTIMER4 : constant := 16#f0005c04#;  --  lm4f120/sysctl.h:181
   SYSCTL_PERIPH_WTIMER5 : constant := 16#f0005c05#;  --  lm4f120/sysctl.h:182
   SYSCTL_PERIPH2_UART0 : constant := 16#f0001800#;  --  lm4f120/sysctl.h:183
   SYSCTL_PERIPH2_UART1 : constant := 16#f0001801#;  --  lm4f120/sysctl.h:184
   SYSCTL_PERIPH2_UART2 : constant := 16#f0001802#;  --  lm4f120/sysctl.h:185
   SYSCTL_PERIPH_UART3 : constant := 16#f0001803#;  --  lm4f120/sysctl.h:186
   SYSCTL_PERIPH_UART4 : constant := 16#f0001804#;  --  lm4f120/sysctl.h:187
   SYSCTL_PERIPH_UART5 : constant := 16#f0001805#;  --  lm4f120/sysctl.h:188
   SYSCTL_PERIPH_UART6 : constant := 16#f0001806#;  --  lm4f120/sysctl.h:189
   SYSCTL_PERIPH_UART7 : constant := 16#f0001807#;  --  lm4f120/sysctl.h:190
   SYSCTL_PERIPH2_UDMA : constant := 16#f0000c00#;  --  lm4f120/sysctl.h:191
   SYSCTL_PERIPH2_USB0 : constant := 16#f0002800#;  --  lm4f120/sysctl.h:192
   SYSCTL_PERIPH2_WDOG0 : constant := 16#f0000000#;  --  lm4f120/sysctl.h:193
   SYSCTL_PERIPH2_WDOG1 : constant := 16#f0000001#;  --  lm4f120/sysctl.h:194
   SYSCTL_PERIPH2_HIBERNATE : constant := 16#f0001400#;  --  lm4f120/sysctl.h:195

   SYSCTL_PIN_PWM0 : constant := 16#00000001#;  --  lm4f120/sysctl.h:204
   SYSCTL_PIN_PWM1 : constant := 16#00000002#;  --  lm4f120/sysctl.h:205
   SYSCTL_PIN_PWM2 : constant := 16#00000004#;  --  lm4f120/sysctl.h:206
   SYSCTL_PIN_PWM3 : constant := 16#00000008#;  --  lm4f120/sysctl.h:207
   SYSCTL_PIN_PWM4 : constant := 16#00000010#;  --  lm4f120/sysctl.h:208
   SYSCTL_PIN_PWM5 : constant := 16#00000020#;  --  lm4f120/sysctl.h:209
   SYSCTL_PIN_PWM6 : constant := 16#00000040#;  --  lm4f120/sysctl.h:210
   SYSCTL_PIN_PWM7 : constant := 16#00000080#;  --  lm4f120/sysctl.h:211
   SYSCTL_PIN_C0MINUS : constant := 16#00000040#;  --  lm4f120/sysctl.h:212
   SYSCTL_PIN_C0PLUS : constant := 16#00000080#;  --  lm4f120/sysctl.h:213
   SYSCTL_PIN_C0O : constant := 16#00000100#;  --  lm4f120/sysctl.h:214
   SYSCTL_PIN_C1MINUS : constant := 16#00000200#;  --  lm4f120/sysctl.h:215
   SYSCTL_PIN_C1PLUS : constant := 16#00000400#;  --  lm4f120/sysctl.h:216
   SYSCTL_PIN_C1O : constant := 16#00000800#;  --  lm4f120/sysctl.h:217
   SYSCTL_PIN_C2MINUS : constant := 16#00001000#;  --  lm4f120/sysctl.h:218
   SYSCTL_PIN_C2PLUS : constant := 16#00002000#;  --  lm4f120/sysctl.h:219
   SYSCTL_PIN_C2O : constant := 16#00004000#;  --  lm4f120/sysctl.h:220
   SYSCTL_PIN_MC_FAULT0 : constant := 16#00008000#;  --  lm4f120/sysctl.h:221
   SYSCTL_PIN_ADC0 : constant := 16#00010000#;  --  lm4f120/sysctl.h:222
   SYSCTL_PIN_ADC1 : constant := 16#00020000#;  --  lm4f120/sysctl.h:223
   SYSCTL_PIN_ADC2 : constant := 16#00040000#;  --  lm4f120/sysctl.h:224
   SYSCTL_PIN_ADC3 : constant := 16#00080000#;  --  lm4f120/sysctl.h:225
   SYSCTL_PIN_ADC4 : constant := 16#00100000#;  --  lm4f120/sysctl.h:226
   SYSCTL_PIN_ADC5 : constant := 16#00200000#;  --  lm4f120/sysctl.h:227
   SYSCTL_PIN_ADC6 : constant := 16#00400000#;  --  lm4f120/sysctl.h:228
   SYSCTL_PIN_ADC7 : constant := 16#00800000#;  --  lm4f120/sysctl.h:229
   SYSCTL_PIN_CCP0 : constant := 16#01000000#;  --  lm4f120/sysctl.h:230
   SYSCTL_PIN_CCP1 : constant := 16#02000000#;  --  lm4f120/sysctl.h:231
   SYSCTL_PIN_CCP2 : constant := 16#04000000#;  --  lm4f120/sysctl.h:232
   SYSCTL_PIN_CCP3 : constant := 16#08000000#;  --  lm4f120/sysctl.h:233
   SYSCTL_PIN_CCP4 : constant := 16#10000000#;  --  lm4f120/sysctl.h:234
   SYSCTL_PIN_CCP5 : constant := 16#20000000#;  --  lm4f120/sysctl.h:235
   SYSCTL_PIN_32KHZ : constant := 16#80000000#;  --  lm4f120/sysctl.h:236

   SYSCTL_LDO_2_25V : constant := 16#00000005#;  --  lm4f120/sysctl.h:244
   SYSCTL_LDO_2_30V : constant := 16#00000004#;  --  lm4f120/sysctl.h:245
   SYSCTL_LDO_2_35V : constant := 16#00000003#;  --  lm4f120/sysctl.h:246
   SYSCTL_LDO_2_40V : constant := 16#00000002#;  --  lm4f120/sysctl.h:247
   SYSCTL_LDO_2_45V : constant := 16#00000001#;  --  lm4f120/sysctl.h:248
   SYSCTL_LDO_2_50V : constant := 16#00000000#;  --  lm4f120/sysctl.h:249
   SYSCTL_LDO_2_55V : constant := 16#0000001f#;  --  lm4f120/sysctl.h:250
   SYSCTL_LDO_2_60V : constant := 16#0000001e#;  --  lm4f120/sysctl.h:251
   SYSCTL_LDO_2_65V : constant := 16#0000001d#;  --  lm4f120/sysctl.h:252
   SYSCTL_LDO_2_70V : constant := 16#0000001c#;  --  lm4f120/sysctl.h:253
   SYSCTL_LDO_2_75V : constant := 16#0000001b#;  --  lm4f120/sysctl.h:254

   SYSCTL_LDOCFG_ARST : constant := 16#00000001#;  --  lm4f120/sysctl.h:261
   SYSCTL_LDOCFG_NORST : constant := 16#00000000#;  --  lm4f120/sysctl.h:262

   SYSCTL_INT_MOSC_PUP : constant := 16#00000100#;  --  lm4f120/sysctl.h:271
   SYSCTL_INT_USBPLL_LOCK : constant := 16#00000080#;  --  lm4f120/sysctl.h:272
   SYSCTL_INT_PLL_LOCK : constant := 16#00000040#;  --  lm4f120/sysctl.h:273
   SYSCTL_INT_CUR_LIMIT : constant := 16#00000020#;  --  lm4f120/sysctl.h:274
   SYSCTL_INT_IOSC_FAIL : constant := 16#00000010#;  --  lm4f120/sysctl.h:275
   SYSCTL_INT_MOSC_FAIL : constant := 16#00000008#;  --  lm4f120/sysctl.h:276
   SYSCTL_INT_POR : constant := 16#00000004#;  --  lm4f120/sysctl.h:277
   SYSCTL_INT_BOR : constant := 16#00000002#;  --  lm4f120/sysctl.h:278
   SYSCTL_INT_PLL_FAIL : constant := 16#00000001#;  --  lm4f120/sysctl.h:279

   SYSCTL_CAUSE_LDO : constant := 16#00000020#;  --  lm4f120/sysctl.h:287
   SYSCTL_CAUSE_WDOG1 : constant := 16#00000020#;  --  lm4f120/sysctl.h:288
   SYSCTL_CAUSE_SW : constant := 16#00000010#;  --  lm4f120/sysctl.h:289
   SYSCTL_CAUSE_WDOG0 : constant := 16#00000008#;  --  lm4f120/sysctl.h:290
   SYSCTL_CAUSE_WDOG : constant := 16#00000008#;  --  lm4f120/sysctl.h:291
   SYSCTL_CAUSE_BOR : constant := 16#00000004#;  --  lm4f120/sysctl.h:292
   SYSCTL_CAUSE_POR : constant := 16#00000002#;  --  lm4f120/sysctl.h:293
   SYSCTL_CAUSE_EXT : constant := 16#00000001#;  --  lm4f120/sysctl.h:294

   SYSCTL_BOR_RESET : constant := 16#00000002#;  --  lm4f120/sysctl.h:302
   SYSCTL_BOR_RESAMPLE : constant := 16#00000001#;  --  lm4f120/sysctl.h:303

   SYSCTL_PWMDIV_1 : constant := 16#00000000#;  --  lm4f120/sysctl.h:312
   SYSCTL_PWMDIV_2 : constant := 16#00100000#;  --  lm4f120/sysctl.h:313
   SYSCTL_PWMDIV_4 : constant := 16#00120000#;  --  lm4f120/sysctl.h:314
   SYSCTL_PWMDIV_8 : constant := 16#00140000#;  --  lm4f120/sysctl.h:315
   SYSCTL_PWMDIV_16 : constant := 16#00160000#;  --  lm4f120/sysctl.h:316
   SYSCTL_PWMDIV_32 : constant := 16#00180000#;  --  lm4f120/sysctl.h:317
   SYSCTL_PWMDIV_64 : constant := 16#001A0000#;  --  lm4f120/sysctl.h:318

   SYSCTL_ADCSPEED_1MSPS : constant := 16#00000F00#;  --  lm4f120/sysctl.h:327
   SYSCTL_ADCSPEED_500KSPS : constant := 16#00000A00#;  --  lm4f120/sysctl.h:328
   SYSCTL_ADCSPEED_250KSPS : constant := 16#00000500#;  --  lm4f120/sysctl.h:329
   SYSCTL_ADCSPEED_125KSPS : constant := 16#00000000#;  --  lm4f120/sysctl.h:330

   SYSCTL_SYSDIV_1 : constant := 16#07800000#;  --  lm4f120/sysctl.h:338
   SYSCTL_SYSDIV_2 : constant := 16#00C00000#;  --  lm4f120/sysctl.h:339
   SYSCTL_SYSDIV_3 : constant := 16#01400000#;  --  lm4f120/sysctl.h:340
   SYSCTL_SYSDIV_4 : constant := 16#01C00000#;  --  lm4f120/sysctl.h:341
   SYSCTL_SYSDIV_5 : constant := 16#02400000#;  --  lm4f120/sysctl.h:342
   SYSCTL_SYSDIV_6 : constant := 16#02C00000#;  --  lm4f120/sysctl.h:343
   SYSCTL_SYSDIV_7 : constant := 16#03400000#;  --  lm4f120/sysctl.h:344
   SYSCTL_SYSDIV_8 : constant := 16#03C00000#;  --  lm4f120/sysctl.h:345
   SYSCTL_SYSDIV_9 : constant := 16#04400000#;  --  lm4f120/sysctl.h:346
   SYSCTL_SYSDIV_10 : constant := 16#04C00000#;  --  lm4f120/sysctl.h:347
   SYSCTL_SYSDIV_11 : constant := 16#05400000#;  --  lm4f120/sysctl.h:348
   SYSCTL_SYSDIV_12 : constant := 16#05C00000#;  --  lm4f120/sysctl.h:349
   SYSCTL_SYSDIV_13 : constant := 16#06400000#;  --  lm4f120/sysctl.h:350
   SYSCTL_SYSDIV_14 : constant := 16#06C00000#;  --  lm4f120/sysctl.h:351
   SYSCTL_SYSDIV_15 : constant := 16#07400000#;  --  lm4f120/sysctl.h:352
   SYSCTL_SYSDIV_16 : constant := 16#07C00000#;  --  lm4f120/sysctl.h:353
   SYSCTL_SYSDIV_17 : constant := 16#88400000#;  --  lm4f120/sysctl.h:354
   SYSCTL_SYSDIV_18 : constant := 16#88C00000#;  --  lm4f120/sysctl.h:355
   SYSCTL_SYSDIV_19 : constant := 16#89400000#;  --  lm4f120/sysctl.h:356
   SYSCTL_SYSDIV_20 : constant := 16#89C00000#;  --  lm4f120/sysctl.h:357
   SYSCTL_SYSDIV_21 : constant := 16#8A400000#;  --  lm4f120/sysctl.h:358
   SYSCTL_SYSDIV_22 : constant := 16#8AC00000#;  --  lm4f120/sysctl.h:359
   SYSCTL_SYSDIV_23 : constant := 16#8B400000#;  --  lm4f120/sysctl.h:360
   SYSCTL_SYSDIV_24 : constant := 16#8BC00000#;  --  lm4f120/sysctl.h:361
   SYSCTL_SYSDIV_25 : constant := 16#8C400000#;  --  lm4f120/sysctl.h:362
   SYSCTL_SYSDIV_26 : constant := 16#8CC00000#;  --  lm4f120/sysctl.h:363
   SYSCTL_SYSDIV_27 : constant := 16#8D400000#;  --  lm4f120/sysctl.h:364
   SYSCTL_SYSDIV_28 : constant := 16#8DC00000#;  --  lm4f120/sysctl.h:365
   SYSCTL_SYSDIV_29 : constant := 16#8E400000#;  --  lm4f120/sysctl.h:366
   SYSCTL_SYSDIV_30 : constant := 16#8EC00000#;  --  lm4f120/sysctl.h:367
   SYSCTL_SYSDIV_31 : constant := 16#8F400000#;  --  lm4f120/sysctl.h:368
   SYSCTL_SYSDIV_32 : constant := 16#8FC00000#;  --  lm4f120/sysctl.h:369
   SYSCTL_SYSDIV_33 : constant := 16#90400000#;  --  lm4f120/sysctl.h:370
   SYSCTL_SYSDIV_34 : constant := 16#90C00000#;  --  lm4f120/sysctl.h:371
   SYSCTL_SYSDIV_35 : constant := 16#91400000#;  --  lm4f120/sysctl.h:372
   SYSCTL_SYSDIV_36 : constant := 16#91C00000#;  --  lm4f120/sysctl.h:373
   SYSCTL_SYSDIV_37 : constant := 16#92400000#;  --  lm4f120/sysctl.h:374
   SYSCTL_SYSDIV_38 : constant := 16#92C00000#;  --  lm4f120/sysctl.h:375
   SYSCTL_SYSDIV_39 : constant := 16#93400000#;  --  lm4f120/sysctl.h:376
   SYSCTL_SYSDIV_40 : constant := 16#93C00000#;  --  lm4f120/sysctl.h:377
   SYSCTL_SYSDIV_41 : constant := 16#94400000#;  --  lm4f120/sysctl.h:378
   SYSCTL_SYSDIV_42 : constant := 16#94C00000#;  --  lm4f120/sysctl.h:379
   SYSCTL_SYSDIV_43 : constant := 16#95400000#;  --  lm4f120/sysctl.h:380
   SYSCTL_SYSDIV_44 : constant := 16#95C00000#;  --  lm4f120/sysctl.h:381
   SYSCTL_SYSDIV_45 : constant := 16#96400000#;  --  lm4f120/sysctl.h:382
   SYSCTL_SYSDIV_46 : constant := 16#96C00000#;  --  lm4f120/sysctl.h:383
   SYSCTL_SYSDIV_47 : constant := 16#97400000#;  --  lm4f120/sysctl.h:384
   SYSCTL_SYSDIV_48 : constant := 16#97C00000#;  --  lm4f120/sysctl.h:385
   SYSCTL_SYSDIV_49 : constant := 16#98400000#;  --  lm4f120/sysctl.h:386
   SYSCTL_SYSDIV_50 : constant := 16#98C00000#;  --  lm4f120/sysctl.h:387
   SYSCTL_SYSDIV_51 : constant := 16#99400000#;  --  lm4f120/sysctl.h:388
   SYSCTL_SYSDIV_52 : constant := 16#99C00000#;  --  lm4f120/sysctl.h:389
   SYSCTL_SYSDIV_53 : constant := 16#9A400000#;  --  lm4f120/sysctl.h:390
   SYSCTL_SYSDIV_54 : constant := 16#9AC00000#;  --  lm4f120/sysctl.h:391
   SYSCTL_SYSDIV_55 : constant := 16#9B400000#;  --  lm4f120/sysctl.h:392
   SYSCTL_SYSDIV_56 : constant := 16#9BC00000#;  --  lm4f120/sysctl.h:393
   SYSCTL_SYSDIV_57 : constant := 16#9C400000#;  --  lm4f120/sysctl.h:394
   SYSCTL_SYSDIV_58 : constant := 16#9CC00000#;  --  lm4f120/sysctl.h:395
   SYSCTL_SYSDIV_59 : constant := 16#9D400000#;  --  lm4f120/sysctl.h:396
   SYSCTL_SYSDIV_60 : constant := 16#9DC00000#;  --  lm4f120/sysctl.h:397
   SYSCTL_SYSDIV_61 : constant := 16#9E400000#;  --  lm4f120/sysctl.h:398
   SYSCTL_SYSDIV_62 : constant := 16#9EC00000#;  --  lm4f120/sysctl.h:399
   SYSCTL_SYSDIV_63 : constant := 16#9F400000#;  --  lm4f120/sysctl.h:400
   SYSCTL_SYSDIV_64 : constant := 16#9FC00000#;  --  lm4f120/sysctl.h:401
   SYSCTL_SYSDIV_2_5 : constant := 16#C1000000#;  --  lm4f120/sysctl.h:402
   SYSCTL_SYSDIV_3_5 : constant := 16#C1800000#;  --  lm4f120/sysctl.h:403
   SYSCTL_SYSDIV_4_5 : constant := 16#C2000000#;  --  lm4f120/sysctl.h:404
   SYSCTL_SYSDIV_5_5 : constant := 16#C2800000#;  --  lm4f120/sysctl.h:405
   SYSCTL_SYSDIV_6_5 : constant := 16#C3000000#;  --  lm4f120/sysctl.h:406
   SYSCTL_SYSDIV_7_5 : constant := 16#C3800000#;  --  lm4f120/sysctl.h:407
   SYSCTL_SYSDIV_8_5 : constant := 16#C4000000#;  --  lm4f120/sysctl.h:408
   SYSCTL_SYSDIV_9_5 : constant := 16#C4800000#;  --  lm4f120/sysctl.h:409
   SYSCTL_SYSDIV_10_5 : constant := 16#C5000000#;  --  lm4f120/sysctl.h:410
   SYSCTL_SYSDIV_11_5 : constant := 16#C5800000#;  --  lm4f120/sysctl.h:411
   SYSCTL_SYSDIV_12_5 : constant := 16#C6000000#;  --  lm4f120/sysctl.h:412
   SYSCTL_SYSDIV_13_5 : constant := 16#C6800000#;  --  lm4f120/sysctl.h:413
   SYSCTL_SYSDIV_14_5 : constant := 16#C7000000#;  --  lm4f120/sysctl.h:414
   SYSCTL_SYSDIV_15_5 : constant := 16#C7800000#;  --  lm4f120/sysctl.h:415
   SYSCTL_SYSDIV_16_5 : constant := 16#C8000000#;  --  lm4f120/sysctl.h:416
   SYSCTL_SYSDIV_17_5 : constant := 16#C8800000#;  --  lm4f120/sysctl.h:417
   SYSCTL_SYSDIV_18_5 : constant := 16#C9000000#;  --  lm4f120/sysctl.h:418
   SYSCTL_SYSDIV_19_5 : constant := 16#C9800000#;  --  lm4f120/sysctl.h:419
   SYSCTL_SYSDIV_20_5 : constant := 16#CA000000#;  --  lm4f120/sysctl.h:420
   SYSCTL_SYSDIV_21_5 : constant := 16#CA800000#;  --  lm4f120/sysctl.h:421
   SYSCTL_SYSDIV_22_5 : constant := 16#CB000000#;  --  lm4f120/sysctl.h:422
   SYSCTL_SYSDIV_23_5 : constant := 16#CB800000#;  --  lm4f120/sysctl.h:423
   SYSCTL_SYSDIV_24_5 : constant := 16#CC000000#;  --  lm4f120/sysctl.h:424
   SYSCTL_SYSDIV_25_5 : constant := 16#CC800000#;  --  lm4f120/sysctl.h:425
   SYSCTL_SYSDIV_26_5 : constant := 16#CD000000#;  --  lm4f120/sysctl.h:426
   SYSCTL_SYSDIV_27_5 : constant := 16#CD800000#;  --  lm4f120/sysctl.h:427
   SYSCTL_SYSDIV_28_5 : constant := 16#CE000000#;  --  lm4f120/sysctl.h:428
   SYSCTL_SYSDIV_29_5 : constant := 16#CE800000#;  --  lm4f120/sysctl.h:429
   SYSCTL_SYSDIV_30_5 : constant := 16#CF000000#;  --  lm4f120/sysctl.h:430
   SYSCTL_SYSDIV_31_5 : constant := 16#CF800000#;  --  lm4f120/sysctl.h:431
   SYSCTL_SYSDIV_32_5 : constant := 16#D0000000#;  --  lm4f120/sysctl.h:432
   SYSCTL_SYSDIV_33_5 : constant := 16#D0800000#;  --  lm4f120/sysctl.h:433
   SYSCTL_SYSDIV_34_5 : constant := 16#D1000000#;  --  lm4f120/sysctl.h:434
   SYSCTL_SYSDIV_35_5 : constant := 16#D1800000#;  --  lm4f120/sysctl.h:435
   SYSCTL_SYSDIV_36_5 : constant := 16#D2000000#;  --  lm4f120/sysctl.h:436
   SYSCTL_SYSDIV_37_5 : constant := 16#D2800000#;  --  lm4f120/sysctl.h:437
   SYSCTL_SYSDIV_38_5 : constant := 16#D3000000#;  --  lm4f120/sysctl.h:438
   SYSCTL_SYSDIV_39_5 : constant := 16#D3800000#;  --  lm4f120/sysctl.h:439
   SYSCTL_SYSDIV_40_5 : constant := 16#D4000000#;  --  lm4f120/sysctl.h:440
   SYSCTL_SYSDIV_41_5 : constant := 16#D4800000#;  --  lm4f120/sysctl.h:441
   SYSCTL_SYSDIV_42_5 : constant := 16#D5000000#;  --  lm4f120/sysctl.h:442
   SYSCTL_SYSDIV_43_5 : constant := 16#D5800000#;  --  lm4f120/sysctl.h:443
   SYSCTL_SYSDIV_44_5 : constant := 16#D6000000#;  --  lm4f120/sysctl.h:444
   SYSCTL_SYSDIV_45_5 : constant := 16#D6800000#;  --  lm4f120/sysctl.h:445
   SYSCTL_SYSDIV_46_5 : constant := 16#D7000000#;  --  lm4f120/sysctl.h:446
   SYSCTL_SYSDIV_47_5 : constant := 16#D7800000#;  --  lm4f120/sysctl.h:447
   SYSCTL_SYSDIV_48_5 : constant := 16#D8000000#;  --  lm4f120/sysctl.h:448
   SYSCTL_SYSDIV_49_5 : constant := 16#D8800000#;  --  lm4f120/sysctl.h:449
   SYSCTL_SYSDIV_50_5 : constant := 16#D9000000#;  --  lm4f120/sysctl.h:450
   SYSCTL_SYSDIV_51_5 : constant := 16#D9800000#;  --  lm4f120/sysctl.h:451
   SYSCTL_SYSDIV_52_5 : constant := 16#DA000000#;  --  lm4f120/sysctl.h:452
   SYSCTL_SYSDIV_53_5 : constant := 16#DA800000#;  --  lm4f120/sysctl.h:453
   SYSCTL_SYSDIV_54_5 : constant := 16#DB000000#;  --  lm4f120/sysctl.h:454
   SYSCTL_SYSDIV_55_5 : constant := 16#DB800000#;  --  lm4f120/sysctl.h:455
   SYSCTL_SYSDIV_56_5 : constant := 16#DC000000#;  --  lm4f120/sysctl.h:456
   SYSCTL_SYSDIV_57_5 : constant := 16#DC800000#;  --  lm4f120/sysctl.h:457
   SYSCTL_SYSDIV_58_5 : constant := 16#DD000000#;  --  lm4f120/sysctl.h:458
   SYSCTL_SYSDIV_59_5 : constant := 16#DD800000#;  --  lm4f120/sysctl.h:459
   SYSCTL_SYSDIV_60_5 : constant := 16#DE000000#;  --  lm4f120/sysctl.h:460
   SYSCTL_SYSDIV_61_5 : constant := 16#DE800000#;  --  lm4f120/sysctl.h:461
   SYSCTL_SYSDIV_62_5 : constant := 16#DF000000#;  --  lm4f120/sysctl.h:462
   SYSCTL_SYSDIV_63_5 : constant := 16#DF800000#;  --  lm4f120/sysctl.h:463
   SYSCTL_USE_PLL : constant := 16#00000000#;  --  lm4f120/sysctl.h:464
   SYSCTL_USE_OSC : constant := 16#00003800#;  --  lm4f120/sysctl.h:465
   SYSCTL_XTAL_1MHZ : constant := 16#00000000#;  --  lm4f120/sysctl.h:466
   SYSCTL_XTAL_1_84MHZ : constant := 16#00000040#;  --  lm4f120/sysctl.h:467
   SYSCTL_XTAL_2MHZ : constant := 16#00000080#;  --  lm4f120/sysctl.h:468
   SYSCTL_XTAL_2_45MHZ : constant := 16#000000C0#;  --  lm4f120/sysctl.h:469
   SYSCTL_XTAL_3_57MHZ : constant := 16#00000100#;  --  lm4f120/sysctl.h:470
   SYSCTL_XTAL_3_68MHZ : constant := 16#00000140#;  --  lm4f120/sysctl.h:471
   SYSCTL_XTAL_4MHZ : constant := 16#00000180#;  --  lm4f120/sysctl.h:472
   SYSCTL_XTAL_4_09MHZ : constant := 16#000001C0#;  --  lm4f120/sysctl.h:473
   SYSCTL_XTAL_4_91MHZ : constant := 16#00000200#;  --  lm4f120/sysctl.h:474
   SYSCTL_XTAL_5MHZ : constant := 16#00000240#;  --  lm4f120/sysctl.h:475
   SYSCTL_XTAL_5_12MHZ : constant := 16#00000280#;  --  lm4f120/sysctl.h:476
   SYSCTL_XTAL_6MHZ : constant := 16#000002C0#;  --  lm4f120/sysctl.h:477
   SYSCTL_XTAL_6_14MHZ : constant := 16#00000300#;  --  lm4f120/sysctl.h:478
   SYSCTL_XTAL_7_37MHZ : constant := 16#00000340#;  --  lm4f120/sysctl.h:479
   SYSCTL_XTAL_8MHZ : constant := 16#00000380#;  --  lm4f120/sysctl.h:480
   SYSCTL_XTAL_8_19MHZ : constant := 16#000003C0#;  --  lm4f120/sysctl.h:481
   SYSCTL_XTAL_10MHZ : constant := 16#00000400#;  --  lm4f120/sysctl.h:482
   SYSCTL_XTAL_12MHZ : constant := 16#00000440#;  --  lm4f120/sysctl.h:483
   SYSCTL_XTAL_12_2MHZ : constant := 16#00000480#;  --  lm4f120/sysctl.h:484
   SYSCTL_XTAL_13_5MHZ : constant := 16#000004C0#;  --  lm4f120/sysctl.h:485
   SYSCTL_XTAL_14_3MHZ : constant := 16#00000500#;  --  lm4f120/sysctl.h:486
   SYSCTL_XTAL_16MHZ : constant := 16#00000540#;  --  lm4f120/sysctl.h:487
   SYSCTL_XTAL_16_3MHZ : constant := 16#00000580#;  --  lm4f120/sysctl.h:488
   SYSCTL_XTAL_18MHZ : constant := 16#000005C0#;  --  lm4f120/sysctl.h:489
   SYSCTL_XTAL_20MHZ : constant := 16#00000600#;  --  lm4f120/sysctl.h:490
   SYSCTL_XTAL_24MHZ : constant := 16#00000640#;  --  lm4f120/sysctl.h:491
   SYSCTL_XTAL_25MHZ : constant := 16#00000680#;  --  lm4f120/sysctl.h:492
   SYSCTL_OSC_MAIN : constant := 16#00000000#;  --  lm4f120/sysctl.h:493
   SYSCTL_OSC_INT : constant := 16#00000010#;  --  lm4f120/sysctl.h:494
   SYSCTL_OSC_INT4 : constant := 16#00000020#;  --  lm4f120/sysctl.h:495
   SYSCTL_OSC_INT30 : constant := 16#00000030#;  --  lm4f120/sysctl.h:496
   SYSCTL_OSC_EXT4_19 : constant := 16#80000028#;  --  lm4f120/sysctl.h:497
   SYSCTL_OSC_EXT32 : constant := 16#80000038#;  --  lm4f120/sysctl.h:498
   SYSCTL_INT_OSC_DIS : constant := 16#00000002#;  --  lm4f120/sysctl.h:499
   SYSCTL_MAIN_OSC_DIS : constant := 16#00000001#;  --  lm4f120/sysctl.h:500

   SYSCTL_DSLP_DIV_1 : constant := 16#00000000#;  --  lm4f120/sysctl.h:508
   SYSCTL_DSLP_DIV_2 : constant := 16#00800000#;  --  lm4f120/sysctl.h:509
   SYSCTL_DSLP_DIV_3 : constant := 16#01000000#;  --  lm4f120/sysctl.h:510
   SYSCTL_DSLP_DIV_4 : constant := 16#01800000#;  --  lm4f120/sysctl.h:511
   SYSCTL_DSLP_DIV_5 : constant := 16#02000000#;  --  lm4f120/sysctl.h:512
   SYSCTL_DSLP_DIV_6 : constant := 16#02800000#;  --  lm4f120/sysctl.h:513
   SYSCTL_DSLP_DIV_7 : constant := 16#03000000#;  --  lm4f120/sysctl.h:514
   SYSCTL_DSLP_DIV_8 : constant := 16#03800000#;  --  lm4f120/sysctl.h:515
   SYSCTL_DSLP_DIV_9 : constant := 16#04000000#;  --  lm4f120/sysctl.h:516
   SYSCTL_DSLP_DIV_10 : constant := 16#04800000#;  --  lm4f120/sysctl.h:517
   SYSCTL_DSLP_DIV_11 : constant := 16#05000000#;  --  lm4f120/sysctl.h:518
   SYSCTL_DSLP_DIV_12 : constant := 16#05800000#;  --  lm4f120/sysctl.h:519
   SYSCTL_DSLP_DIV_13 : constant := 16#06000000#;  --  lm4f120/sysctl.h:520
   SYSCTL_DSLP_DIV_14 : constant := 16#06800000#;  --  lm4f120/sysctl.h:521
   SYSCTL_DSLP_DIV_15 : constant := 16#07000000#;  --  lm4f120/sysctl.h:522
   SYSCTL_DSLP_DIV_16 : constant := 16#07800000#;  --  lm4f120/sysctl.h:523
   SYSCTL_DSLP_DIV_17 : constant := 16#08000000#;  --  lm4f120/sysctl.h:524
   SYSCTL_DSLP_DIV_18 : constant := 16#08800000#;  --  lm4f120/sysctl.h:525
   SYSCTL_DSLP_DIV_19 : constant := 16#09000000#;  --  lm4f120/sysctl.h:526
   SYSCTL_DSLP_DIV_20 : constant := 16#09800000#;  --  lm4f120/sysctl.h:527
   SYSCTL_DSLP_DIV_21 : constant := 16#0A000000#;  --  lm4f120/sysctl.h:528
   SYSCTL_DSLP_DIV_22 : constant := 16#0A800000#;  --  lm4f120/sysctl.h:529
   SYSCTL_DSLP_DIV_23 : constant := 16#0B000000#;  --  lm4f120/sysctl.h:530
   SYSCTL_DSLP_DIV_24 : constant := 16#0B800000#;  --  lm4f120/sysctl.h:531
   SYSCTL_DSLP_DIV_25 : constant := 16#0C000000#;  --  lm4f120/sysctl.h:532
   SYSCTL_DSLP_DIV_26 : constant := 16#0C800000#;  --  lm4f120/sysctl.h:533
   SYSCTL_DSLP_DIV_27 : constant := 16#0D000000#;  --  lm4f120/sysctl.h:534
   SYSCTL_DSLP_DIV_28 : constant := 16#0D800000#;  --  lm4f120/sysctl.h:535
   SYSCTL_DSLP_DIV_29 : constant := 16#0E000000#;  --  lm4f120/sysctl.h:536
   SYSCTL_DSLP_DIV_30 : constant := 16#0E800000#;  --  lm4f120/sysctl.h:537
   SYSCTL_DSLP_DIV_31 : constant := 16#0F000000#;  --  lm4f120/sysctl.h:538
   SYSCTL_DSLP_DIV_32 : constant := 16#0F800000#;  --  lm4f120/sysctl.h:539
   SYSCTL_DSLP_DIV_33 : constant := 16#10000000#;  --  lm4f120/sysctl.h:540
   SYSCTL_DSLP_DIV_34 : constant := 16#10800000#;  --  lm4f120/sysctl.h:541
   SYSCTL_DSLP_DIV_35 : constant := 16#11000000#;  --  lm4f120/sysctl.h:542
   SYSCTL_DSLP_DIV_36 : constant := 16#11800000#;  --  lm4f120/sysctl.h:543
   SYSCTL_DSLP_DIV_37 : constant := 16#12000000#;  --  lm4f120/sysctl.h:544
   SYSCTL_DSLP_DIV_38 : constant := 16#12800000#;  --  lm4f120/sysctl.h:545
   SYSCTL_DSLP_DIV_39 : constant := 16#13000000#;  --  lm4f120/sysctl.h:546
   SYSCTL_DSLP_DIV_40 : constant := 16#13800000#;  --  lm4f120/sysctl.h:547
   SYSCTL_DSLP_DIV_41 : constant := 16#14000000#;  --  lm4f120/sysctl.h:548
   SYSCTL_DSLP_DIV_42 : constant := 16#14800000#;  --  lm4f120/sysctl.h:549
   SYSCTL_DSLP_DIV_43 : constant := 16#15000000#;  --  lm4f120/sysctl.h:550
   SYSCTL_DSLP_DIV_44 : constant := 16#15800000#;  --  lm4f120/sysctl.h:551
   SYSCTL_DSLP_DIV_45 : constant := 16#16000000#;  --  lm4f120/sysctl.h:552
   SYSCTL_DSLP_DIV_46 : constant := 16#16800000#;  --  lm4f120/sysctl.h:553
   SYSCTL_DSLP_DIV_47 : constant := 16#17000000#;  --  lm4f120/sysctl.h:554
   SYSCTL_DSLP_DIV_48 : constant := 16#17800000#;  --  lm4f120/sysctl.h:555
   SYSCTL_DSLP_DIV_49 : constant := 16#18000000#;  --  lm4f120/sysctl.h:556
   SYSCTL_DSLP_DIV_50 : constant := 16#18800000#;  --  lm4f120/sysctl.h:557
   SYSCTL_DSLP_DIV_51 : constant := 16#19000000#;  --  lm4f120/sysctl.h:558
   SYSCTL_DSLP_DIV_52 : constant := 16#19800000#;  --  lm4f120/sysctl.h:559
   SYSCTL_DSLP_DIV_53 : constant := 16#1A000000#;  --  lm4f120/sysctl.h:560
   SYSCTL_DSLP_DIV_54 : constant := 16#1A800000#;  --  lm4f120/sysctl.h:561
   SYSCTL_DSLP_DIV_55 : constant := 16#1B000000#;  --  lm4f120/sysctl.h:562
   SYSCTL_DSLP_DIV_56 : constant := 16#1B800000#;  --  lm4f120/sysctl.h:563
   SYSCTL_DSLP_DIV_57 : constant := 16#1C000000#;  --  lm4f120/sysctl.h:564
   SYSCTL_DSLP_DIV_58 : constant := 16#1C800000#;  --  lm4f120/sysctl.h:565
   SYSCTL_DSLP_DIV_59 : constant := 16#1D000000#;  --  lm4f120/sysctl.h:566
   SYSCTL_DSLP_DIV_60 : constant := 16#1D800000#;  --  lm4f120/sysctl.h:567
   SYSCTL_DSLP_DIV_61 : constant := 16#1E000000#;  --  lm4f120/sysctl.h:568
   SYSCTL_DSLP_DIV_62 : constant := 16#1E800000#;  --  lm4f120/sysctl.h:569
   SYSCTL_DSLP_DIV_63 : constant := 16#1F000000#;  --  lm4f120/sysctl.h:570
   SYSCTL_DSLP_DIV_64 : constant := 16#1F800000#;  --  lm4f120/sysctl.h:571
   SYSCTL_DSLP_OSC_MAIN : constant := 16#00000000#;  --  lm4f120/sysctl.h:572
   SYSCTL_DSLP_OSC_INT : constant := 16#00000010#;  --  lm4f120/sysctl.h:573
   SYSCTL_DSLP_OSC_INT30 : constant := 16#00000030#;  --  lm4f120/sysctl.h:574
   SYSCTL_DSLP_OSC_EXT32 : constant := 16#00000070#;  --  lm4f120/sysctl.h:575
   SYSCTL_DSLP_PIOSC_PD : constant := 16#00000002#;  --  lm4f120/sysctl.h:576

   subtype tBoolean is unsigned;  -- lm4f120/sysctl.h:54

   function SysCtlSRAMSizeGet return unsigned_long;  -- lm4f120/sysctl.h:583
   pragma Import (C, SysCtlSRAMSizeGet, "SysCtlSRAMSizeGet");

   function SysCtlFlashSizeGet return unsigned_long;  -- lm4f120/sysctl.h:584
   pragma Import (C, SysCtlFlashSizeGet, "SysCtlFlashSizeGet");

   function SysCtlPinPresent (ulPin : unsigned_long) return tBoolean;  -- lm4f120/sysctl.h:585
   pragma Import (C, SysCtlPinPresent, "SysCtlPinPresent");

   function SysCtlPeripheralPresent (ulPeripheral : unsigned_long) return tBoolean;  -- lm4f120/sysctl.h:586
   pragma Import (C, SysCtlPeripheralPresent, "SysCtlPeripheralPresent");

   function SysCtlPeripheralReady (ulPeripheral : unsigned_long) return tBoolean;  -- lm4f120/sysctl.h:587
   pragma Import (C, SysCtlPeripheralReady, "SysCtlPeripheralReady");

   procedure SysCtlPeripheralPowerOn (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:588
   pragma Import (C, SysCtlPeripheralPowerOn, "SysCtlPeripheralPowerOn");

   procedure SysCtlPeripheralPowerOff (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:589
   pragma Import (C, SysCtlPeripheralPowerOff, "SysCtlPeripheralPowerOff");

   procedure SysCtlPeripheralReset (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:590
   pragma Import (C, SysCtlPeripheralReset, "SysCtlPeripheralReset");

   procedure SysCtlPeripheralEnable (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:591
   pragma Import (C, SysCtlPeripheralEnable, "SysCtlPeripheralEnable");

   procedure SysCtlPeripheralDisable (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:592
   pragma Import (C, SysCtlPeripheralDisable, "SysCtlPeripheralDisable");

   procedure SysCtlPeripheralSleepEnable (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:593
   pragma Import (C, SysCtlPeripheralSleepEnable, "SysCtlPeripheralSleepEnable");

   procedure SysCtlPeripheralSleepDisable (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:594
   pragma Import (C, SysCtlPeripheralSleepDisable, "SysCtlPeripheralSleepDisable");

   procedure SysCtlPeripheralDeepSleepEnable (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:595
   pragma Import (C, SysCtlPeripheralDeepSleepEnable, "SysCtlPeripheralDeepSleepEnable");

   procedure SysCtlPeripheralDeepSleepDisable (ulPeripheral : unsigned_long);  -- lm4f120/sysctl.h:596
   pragma Import (C, SysCtlPeripheralDeepSleepDisable, "SysCtlPeripheralDeepSleepDisable");

   procedure SysCtlPeripheralClockGating (bEnable : tBoolean);  -- lm4f120/sysctl.h:597
   pragma Import (C, SysCtlPeripheralClockGating, "SysCtlPeripheralClockGating");

   procedure SysCtlIntRegister (pfnHandler : access procedure);  -- lm4f120/sysctl.h:598
   pragma Import (C, SysCtlIntRegister, "SysCtlIntRegister");

   procedure SysCtlIntUnregister;  -- lm4f120/sysctl.h:599
   pragma Import (C, SysCtlIntUnregister, "SysCtlIntUnregister");

   procedure SysCtlIntEnable (ulInts : unsigned_long);  -- lm4f120/sysctl.h:600
   pragma Import (C, SysCtlIntEnable, "SysCtlIntEnable");

   procedure SysCtlIntDisable (ulInts : unsigned_long);  -- lm4f120/sysctl.h:601
   pragma Import (C, SysCtlIntDisable, "SysCtlIntDisable");

   procedure SysCtlIntClear (ulInts : unsigned_long);  -- lm4f120/sysctl.h:602
   pragma Import (C, SysCtlIntClear, "SysCtlIntClear");

   function SysCtlIntStatus (bMasked : tBoolean) return unsigned_long;  -- lm4f120/sysctl.h:603
   pragma Import (C, SysCtlIntStatus, "SysCtlIntStatus");

   procedure SysCtlLDOSet (ulVoltage : unsigned_long);  -- lm4f120/sysctl.h:604
   pragma Import (C, SysCtlLDOSet, "SysCtlLDOSet");

   function SysCtlLDOGet return unsigned_long;  -- lm4f120/sysctl.h:605
   pragma Import (C, SysCtlLDOGet, "SysCtlLDOGet");

   procedure SysCtlLDOConfigSet (ulConfig : unsigned_long);  -- lm4f120/sysctl.h:606
   pragma Import (C, SysCtlLDOConfigSet, "SysCtlLDOConfigSet");

   procedure SysCtlReset;  -- lm4f120/sysctl.h:607
   pragma Import (C, SysCtlReset, "SysCtlReset");

   procedure SysCtlSleep;  -- lm4f120/sysctl.h:608
   pragma Import (C, SysCtlSleep, "SysCtlSleep");

   procedure SysCtlDeepSleep;  -- lm4f120/sysctl.h:609
   pragma Import (C, SysCtlDeepSleep, "SysCtlDeepSleep");

   function SysCtlResetCauseGet return unsigned_long;  -- lm4f120/sysctl.h:610
   pragma Import (C, SysCtlResetCauseGet, "SysCtlResetCauseGet");

   procedure SysCtlResetCauseClear (ulCauses : unsigned_long);  -- lm4f120/sysctl.h:611
   pragma Import (C, SysCtlResetCauseClear, "SysCtlResetCauseClear");

   procedure SysCtlBrownOutConfigSet (ulConfig : unsigned_long; ulDelay : unsigned_long);  -- lm4f120/sysctl.h:612
   pragma Import (C, SysCtlBrownOutConfigSet, "SysCtlBrownOutConfigSet");

   procedure SysCtlDelay (ulCount : unsigned_long);  -- lm4f120/sysctl.h:614
   pragma Import (C, SysCtlDelay, "SysCtlDelay");

   procedure SysCtlMOSCConfigSet (ulConfig : unsigned_long);  -- lm4f120/sysctl.h:615
   pragma Import (C, SysCtlMOSCConfigSet, "SysCtlMOSCConfigSet");

   function SysCtlPIOSCCalibrate (ulType : unsigned_long) return unsigned_long;  -- lm4f120/sysctl.h:616
   pragma Import (C, SysCtlPIOSCCalibrate, "SysCtlPIOSCCalibrate");

   procedure SysCtlClockSet (ulConfig : unsigned_long);  -- lm4f120/sysctl.h:617
   pragma Import (C, SysCtlClockSet, "SysCtlClockSet");

   function SysCtlClockGet return unsigned_long;  -- lm4f120/sysctl.h:618
   pragma Import (C, SysCtlClockGet, "SysCtlClockGet");

   procedure SysCtlDeepSleepClockSet (ulConfig : unsigned_long);  -- lm4f120/sysctl.h:619
   pragma Import (C, SysCtlDeepSleepClockSet, "SysCtlDeepSleepClockSet");

   procedure SysCtlPWMClockSet (ulConfig : unsigned_long);  -- lm4f120/sysctl.h:620
   pragma Import (C, SysCtlPWMClockSet, "SysCtlPWMClockSet");

   function SysCtlPWMClockGet return unsigned_long;  -- lm4f120/sysctl.h:621
   pragma Import (C, SysCtlPWMClockGet, "SysCtlPWMClockGet");

   procedure SysCtlADCSpeedSet (ulSpeed : unsigned_long);  -- lm4f120/sysctl.h:622
   pragma Import (C, SysCtlADCSpeedSet, "SysCtlADCSpeedSet");

   function SysCtlADCSpeedGet return unsigned_long;  -- lm4f120/sysctl.h:623
   pragma Import (C, SysCtlADCSpeedGet, "SysCtlADCSpeedGet");

   procedure SysCtlIOSCVerificationSet (bEnable : tBoolean);  -- lm4f120/sysctl.h:624
   pragma Import (C, SysCtlIOSCVerificationSet, "SysCtlIOSCVerificationSet");

   procedure SysCtlMOSCVerificationSet (bEnable : tBoolean);  -- lm4f120/sysctl.h:625
   pragma Import (C, SysCtlMOSCVerificationSet, "SysCtlMOSCVerificationSet");

   procedure SysCtlPLLVerificationSet (bEnable : tBoolean);  -- lm4f120/sysctl.h:626
   pragma Import (C, SysCtlPLLVerificationSet, "SysCtlPLLVerificationSet");

   procedure SysCtlClkVerificationClear;  -- lm4f120/sysctl.h:627
   pragma Import (C, SysCtlClkVerificationClear, "SysCtlClkVerificationClear");

   procedure SysCtlGPIOAHBEnable (ulGPIOPeripheral : unsigned_long);  -- lm4f120/sysctl.h:628
   pragma Import (C, SysCtlGPIOAHBEnable, "SysCtlGPIOAHBEnable");

   procedure SysCtlGPIOAHBDisable (ulGPIOPeripheral : unsigned_long);  -- lm4f120/sysctl.h:629
   pragma Import (C, SysCtlGPIOAHBDisable, "SysCtlGPIOAHBDisable");

   procedure SysCtlUSBPLLEnable;  -- lm4f120/sysctl.h:630
   pragma Import (C, SysCtlUSBPLLEnable, "SysCtlUSBPLLEnable");

   procedure SysCtlUSBPLLDisable;  -- lm4f120/sysctl.h:631
   pragma Import (C, SysCtlUSBPLLDisable, "SysCtlUSBPLLDisable");

   function SysCtlI2SMClkSet (ulInputClock : unsigned_long; ulMClk : unsigned_long) return unsigned_long;  -- lm4f120/sysctl.h:632
   pragma Import (C, SysCtlI2SMClkSet, "SysCtlI2SMClkSet");

end LM4F120.Sysctl;
