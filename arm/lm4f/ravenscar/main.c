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
#include "driverlib/rom.h"
#include "inc/hw_memmap.h"
#include "inc/hw_types.h"
#include "inc/hw_nvic.h"
#include "driverlib/debug.h"
#include "driverlib/fpu.h"
#include "driverlib/gpio.h"
#include "driverlib/pin_map.h"
#include "driverlib/sysctl.h"
#include "driverlib/uart.h"

typedef unsigned long IRQn_Type;

typedef union
{
  struct
  {
    uint32_t IPSR:9;                      //!< bit:  0.. 8  Exception number
    uint32_t _reserved0:23;              //!< bit:  9..31  Reserved
  } b;                                   //!< Structure used for bit  access
  uint32_t w;                            //!< Type      used for word access
} IPSR_Type;

static inline uint32_t __get_IPSR(void)
{
  uint32_t result;
  __asm volatile ("MRS %0, ipsr" : "=r" (result) );
  return(result);
}


void init_board() 
{
    // Enable lazy stacking for interrupt handlers.
    ROM_FPULazyStackingEnable();

    // Set the clocking to run directly from the crystal.
    // sets the system clock divider to 2.5 (200 MHz PLL divide by 2.5 = 80 MHz)
    ROM_SysCtlClockSet(SYSCTL_SYSDIV_2_5 | SYSCTL_USE_PLL | SYSCTL_XTAL_16MHZ | SYSCTL_OSC_MAIN);

    //_NVIC_PriorityGroupConfig(NVIC_PriorityGroup_4);
    ROM_IntPriorityGroupingSet(NVIC_APINT_PRIGROUP_4_4);


    //
    // Enable the peripherals used by this example.
    // The UART itself needs to be enabled, as well as the GPIO port
    // containing the pins that will be used.
    //
    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);
    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);

    //
    // Configure the GPIO pin muxing for the UART function.
    // This is only necessary if your part supports GPIO pin function muxing.
    // Study the data sheet to see which functions are allocated per pin.
    //
    ROM_GPIOPinConfigure(GPIO_PA0_U0RX);
    ROM_GPIOPinConfigure(GPIO_PA1_U0TX);

    //
    // Since GPIO A0 and A1 are used for the UART function, they must be
    // configured for use as a peripheral function (instead of GPIO).
    //
    ROM_GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_0 | GPIO_PIN_1);

    //
    // Configure the UART for 115,200, 8-N-1 operation.
    // This function uses SysCtlClockGet() to get the system clock
    // frequency.  This could be also be a variable or hard coded value
    // instead of a function call.
    //
    ROM_UARTConfigSetExpClk(UART0_BASE, ROM_SysCtlClockGet(), 115200,
                        (UART_CONFIG_WLEN_8 | UART_CONFIG_STOP_ONE |
                         UART_CONFIG_PAR_NONE));
}

void setup_systick(int frequency) 
{
    //NVIC_SetPriority (PendSV_IRQn, (1<<__NVIC_PRIO_BITS) - 1);
    ROM_IntPrioritySet(14, 15);
    ROM_SysTickPeriodSet(ROM_SysCtlClockGet()/frequency-1);
    // Enable interrupts to the processor.
    ROM_IntMasterEnable();
    // Enable the SysTick Interrupt.
    ROM_SysTickIntEnable();
    // Enable SysTick.
    ROM_SysTickEnable();
}

int get_current_interrupt() 
{
  IPSR_Type ipsr;
  ipsr.w = __get_IPSR();
  return ipsr.b.IPSR;
}

void context_switch() {
  *((uint32_t volatile *)0xE000ED04) = 0x10000000; // trigger PendSV
}

/*
// Export some static inline function for Ada.
void _NVIC_EnableIRQ(IRQn_Type IRQn) {
  IntMasterEnable(  
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

*/

uint32_t _NVIC_GetPriority(IRQn_Type IRQn) {
    return 16 - ROM_IntPriorityGet(IRQn);
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


/*
static inline uint32_t _RCC_GetClocksFreq()
{
  __RCC_GetClocksFreq(&rcc_clk);
  return rcc_clk.HCLK_Frequency;
}


#define AIRCR_VECTKEY_MASK    ((uint32_t)0x05FA0000)
static inline void _NVIC_PriorityGroupConfig(uint32_t NVIC_PriorityGroup)
{
  // Check the parameters 
  assert_param(IS_NVIC_PRIORITY_GROUP(NVIC_PriorityGroup));
  // Set the PRIGROUP[10:8] bits according to NVIC_PriorityGroup value
  SCB->AIRCR = AIRCR_VECTKEY_MASK | NVIC_PriorityGroup;
}
*/
