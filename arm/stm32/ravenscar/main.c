/* ---------------------------------------------------------------------------
--                                                                          --
--                           GNAT RAVENSCAR for NXT                         --
--                                                                          --
--                       Copyright (C) 2010, AdaCore                        --
--                                                                          --
-- This is free software; you can  redistribute it  and/or modify it under  --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion. This is distributed in the hope that it will be useful, but WITH-  --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNARL; see file COPYING.  If not, write --
-- to  the Free Software Foundation,  59 Temple Place - Suite 330,  Boston, --
-- MA 02111-1307, USA.                                                      --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
--------------------------------------------------------------------------- */

#include <stddef.h>
#include <stdint.h>
#include "stm32f10x.h"
#include "system_stm32f10x.h"
#include "stm32f10x_rcc.h"
#include "misc.h"
#include "core_cm3.h"

static RCC_ClocksTypeDef rcc_clk;

//extern void SystemInit(void);
static inline uint32_t _RCC_GetClocksFreq();
static inline void _NVIC_PriorityGroupConfig(uint32_t NVIC_PriorityGroup);

typedef union
{
  struct
  {
    uint32_t ISR:9;                      /*!< bit:  0.. 8  Exception number                   */
    uint32_t _reserved0:23;              /*!< bit:  9..31  Reserved                           */
  } b;                                   /*!< Structure used for bit  access                  */
  uint32_t w;                            /*!< Type      used for word access                  */
} IPSR_Type;


static __INLINE uint32_t __get_IPSR(void)
{
  uint32_t result;
  __ASM volatile ("MRS %0, ipsr" : "=r" (result) );
  return(result);
}

#define CFGR_PLLMull_Mask         ((uint32_t)0x003C0000)
#define CFGR_PLLSRC_Mask          ((uint32_t)0x00010000)
#define CFGR_PLLXTPRE_Mask        ((uint32_t)0x00020000)
#define CFGR_SWS_Mask             ((uint32_t)0x0000000C)
#define CFGR_SW_Mask              ((uint32_t)0xFFFFFFFC)
#define CFGR_HPRE_Reset_Mask      ((uint32_t)0xFFFFFF0F)
#define CFGR_HPRE_Set_Mask        ((uint32_t)0x000000F0)
#define CFGR_PPRE1_Reset_Mask     ((uint32_t)0xFFFFF8FF)
#define CFGR_PPRE1_Set_Mask       ((uint32_t)0x00000700)
#define CFGR_PPRE2_Reset_Mask     ((uint32_t)0xFFFFC7FF)
#define CFGR_PPRE2_Set_Mask       ((uint32_t)0x00003800)
#define CFGR_ADCPRE_Reset_Mask    ((uint32_t)0xFFFF3FFF)
#define CFGR_ADCPRE_Set_Mask      ((uint32_t)0x0000C000)
static __I uint8_t APBAHBPrescTable[16] = {0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 6, 7, 8, 9};
static __I uint8_t ADCPrescTable[4] = {2, 4, 6, 8};

void __RCC_GetClocksFreq(RCC_ClocksTypeDef* RCC_Clocks)
{
  uint32_t tmp = 0, pllmull = 0, pllsource = 0, presc = 0;

#ifdef  STM32F10X_CL
  uint32_t prediv1source = 0, prediv1factor = 0, prediv2factor = 0, pll2mull = 0;
#endif /* STM32F10X_CL */

#if defined (STM32F10X_LD_VL) || defined (STM32F10X_MD_VL) || defined (STM32F10X_HD_VL)
  uint32_t prediv1factor = 0;
#endif
    
  /* Get SYSCLK source -------------------------------------------------------*/
  tmp = RCC->CFGR & CFGR_SWS_Mask;
  
  switch (tmp)
  {
    case 0x00:  /* HSI used as system clock */
      RCC_Clocks->SYSCLK_Frequency = HSI_VALUE;
      break;
    case 0x04:  /* HSE used as system clock */
      RCC_Clocks->SYSCLK_Frequency = HSE_VALUE;
      break;
    case 0x08:  /* PLL used as system clock */

      /* Get PLL clock source and multiplication factor ----------------------*/
      pllmull = RCC->CFGR & CFGR_PLLMull_Mask;
      pllsource = RCC->CFGR & CFGR_PLLSRC_Mask;
      
#ifndef STM32F10X_CL      
      pllmull = ( pllmull >> 18) + 2;
      
      if (pllsource == 0x00)
      {/* HSI oscillator clock divided by 2 selected as PLL clock entry */
        RCC_Clocks->SYSCLK_Frequency = (HSI_VALUE >> 1) * pllmull;
      }
      else
      {
 #if defined (STM32F10X_LD_VL) || defined (STM32F10X_MD_VL) || defined (STM32F10X_HD_VL)
       prediv1factor = (RCC->CFGR2 & CFGR2_PREDIV1) + 1;
       /* HSE oscillator clock selected as PREDIV1 clock entry */
       RCC_Clocks->SYSCLK_Frequency = (HSE_VALUE / prediv1factor) * pllmull; 
 #else
        /* HSE selected as PLL clock entry */
        if ((RCC->CFGR & CFGR_PLLXTPRE_Mask) != (uint32_t)RESET)
        {/* HSE oscillator clock divided by 2 */
          RCC_Clocks->SYSCLK_Frequency = (HSE_VALUE >> 1) * pllmull;
        }
        else
        {
          RCC_Clocks->SYSCLK_Frequency = HSE_VALUE * pllmull;
        }
 #endif
      }
#else
      pllmull = pllmull >> 18;
      
      if (pllmull != 0x0D)
      {
         pllmull += 2;
      }
      else
      { /* PLL multiplication factor = PLL input clock * 6.5 */
        pllmull = 13 / 2; 
      }
            
      if (pllsource == 0x00)
      {/* HSI oscillator clock divided by 2 selected as PLL clock entry */
        RCC_Clocks->SYSCLK_Frequency = (HSI_VALUE >> 1) * pllmull;
      }
      else
      {/* PREDIV1 selected as PLL clock entry */
        
        /* Get PREDIV1 clock source and division factor */
        prediv1source = RCC->CFGR2 & CFGR2_PREDIV1SRC;
        prediv1factor = (RCC->CFGR2 & CFGR2_PREDIV1) + 1;
        
        if (prediv1source == 0)
        { /* HSE oscillator clock selected as PREDIV1 clock entry */
          RCC_Clocks->SYSCLK_Frequency = (HSE_VALUE / prediv1factor) * pllmull;          
        }
        else
        {/* PLL2 clock selected as PREDIV1 clock entry */
          
          /* Get PREDIV2 division factor and PLL2 multiplication factor */
          prediv2factor = ((RCC->CFGR2 & CFGR2_PREDIV2) >> 4) + 1;
          pll2mull = ((RCC->CFGR2 & CFGR2_PLL2MUL) >> 8 ) + 2; 
          RCC_Clocks->SYSCLK_Frequency = (((HSE_VALUE / prediv2factor) * pll2mull) / prediv1factor) * pllmull;                         
        }
      }
#endif /* STM32F10X_CL */ 
      break;

    default:
      RCC_Clocks->SYSCLK_Frequency = HSI_VALUE;
      break;
  }

  /* Compute HCLK, PCLK1, PCLK2 and ADCCLK clocks frequencies ----------------*/
  /* Get HCLK prescaler */
  tmp = RCC->CFGR & CFGR_HPRE_Set_Mask;
  tmp = tmp >> 4;
  presc = APBAHBPrescTable[tmp];
  /* HCLK clock frequency */
  RCC_Clocks->HCLK_Frequency = RCC_Clocks->SYSCLK_Frequency >> presc;
  /* Get PCLK1 prescaler */
  tmp = RCC->CFGR & CFGR_PPRE1_Set_Mask;
  tmp = tmp >> 8;
  presc = APBAHBPrescTable[tmp];
  /* PCLK1 clock frequency */
  RCC_Clocks->PCLK1_Frequency = RCC_Clocks->HCLK_Frequency >> presc;
  /* Get PCLK2 prescaler */
  tmp = RCC->CFGR & CFGR_PPRE2_Set_Mask;
  tmp = tmp >> 11;
  presc = APBAHBPrescTable[tmp];
  /* PCLK2 clock frequency */
  RCC_Clocks->PCLK2_Frequency = RCC_Clocks->HCLK_Frequency >> presc;
  /* Get ADCCLK prescaler */
  tmp = RCC->CFGR & CFGR_ADCPRE_Set_Mask;
  tmp = tmp >> 14;
  presc = ADCPrescTable[tmp];
  /* ADCCLK clock frequency */
  RCC_Clocks->ADCCLK_Frequency = RCC_Clocks->PCLK2_Frequency / presc;
}



void init_board() {
  SystemInit();
  _NVIC_PriorityGroupConfig(NVIC_PriorityGroup_4);


  /* Initialize LEDs and User_Button on STM32F4-Discovery --------------------*/
/*  STM_EVAL_PBInit(BUTTON_USER, BUTTON_MODE_EXTI); 

  STM_EVAL_LEDInit(LED4);
  STM_EVAL_LEDInit(LED3);
  STM_EVAL_LEDInit(LED5);
  STM_EVAL_LEDInit(LED6);

  STM_EVAL_LEDToggle((Led_TypeDef)0);*/
}

void setup_systick(int frequency) {
  SysTick_Config(_RCC_GetClocksFreq() / frequency);
  NVIC_SetPriority (PendSV_IRQn, (1<<__NVIC_PRIO_BITS) - 1);
}

int get_current_interrupt() {
  //return InterruptType->ICTR;
  IPSR_Type ipsr;
  ipsr.w = __get_IPSR();
  return ipsr.b.ISR;
}

void context_switch() {
  *((uint32_t volatile *)0xE000ED04) = 0x10000000; // trigger PendSV
}

// Export some static inline function for Ada.
void _NVIC_EnableIRQ(IRQn_Type IRQn) {
  NVIC_EnableIRQ(IRQn - 16);
}

void _NVIC_DisableIRQ(IRQn_Type IRQn) {
  NVIC_DisableIRQ(IRQn - 16);
}

uint32_t _NVIC_GetPendingIRQ(IRQn_Type IRQn) {
  return NVIC_GetPendingIRQ(IRQn - 16);
}

void _NVIC_SetPendingIRQ(IRQn_Type IRQn) {
  NVIC_SetPendingIRQ(IRQn - 16);
}

void _NVIC_ClearPendingIRQ(IRQn_Type IRQn) {
    NVIC_ClearPendingIRQ(IRQn - 16);
}

uint32_t _NVIC_GetActive(IRQn_Type IRQn) {
    return NVIC_GetActive(IRQn - 16);
}

void _NVIC_SetPriority(IRQn_Type IRQn, uint32_t priority) {
    NVIC_SetPriority(IRQn - 16, 16 - priority);
}

uint32_t _NVIC_GetPriority(IRQn_Type IRQn) {
    return 16 - NVIC_GetPriority(IRQn - 16);
}

void data_abort_pc (void)
{
}

void data_abort_C (void)
{
}
/*
void __aeabi_unwind_cpp_pr0 (void)
{
  while (1) ;
}*/

extern void put_exception (unsigned int) __attribute__ ((weak));

void __attribute__ ((weak)) __gnat_last_chance_handler (void)
{
  unsigned int addr = (int) __builtin_return_address (0);

  if (put_exception != NULL)
    put_exception (addr);

  while (1)
    ;
}

// Adapted from "arti64.c"

long long int __gnat_mulv64 (long long int x, long long int y)
{
  unsigned neg = (x >= 0) ^ (y >= 0);
  long long unsigned xa = x >= 0 ? (long long unsigned) x
                                 : -(long long unsigned) x;
  long long unsigned ya = y >= 0 ? (long long unsigned) y
                                 : -(long long unsigned) y;
  unsigned xhi = (unsigned) (xa >> 32);
  unsigned yhi = (unsigned) (ya >> 32);
  unsigned xlo = (unsigned) xa;
  unsigned ylo = (unsigned) ya;
  long long unsigned mid
    = xhi ? (long long unsigned) xhi * (long long unsigned) ylo
         : (long long unsigned) yhi * (long long unsigned) xlo;
  long long unsigned low = (long long unsigned) xlo * (long long unsigned) ylo;

  if ((xhi && yhi) ||  mid + (low  >> 32) > 0x7fffffff + neg)
    __gnat_last_chance_handler();

  low += ((long long unsigned) (unsigned) mid) << 32;

  return (long long int) (neg ? -low : low);
}


static inline uint32_t _RCC_GetClocksFreq()
{
  __RCC_GetClocksFreq(&rcc_clk);
  return rcc_clk.HCLK_Frequency;
}


#define AIRCR_VECTKEY_MASK    ((uint32_t)0x05FA0000)
static inline void _NVIC_PriorityGroupConfig(uint32_t NVIC_PriorityGroup)
{
  /* Check the parameters */
  assert_param(IS_NVIC_PRIORITY_GROUP(NVIC_PriorityGroup));
  /* Set the PRIGROUP[10:8] bits according to NVIC_PriorityGroup value */
  SCB->AIRCR = AIRCR_VECTKEY_MASK | NVIC_PriorityGroup;
}

