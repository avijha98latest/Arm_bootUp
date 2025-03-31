#include <stdint.h>
#include "nmi.h"
#define SRAM_START   (0x20000000) //  SRAM satrt address
#define SRAM_SIZE    (8U * 1024U) // 8 kb of SRAM
#define SRAM_END     (SRAM_START + SRAM_SIZE)

#define STACK_START  (SRAM_END)

void reset_handler(void);
//void NMI_handler(void)   __attribute__((weak, alias("Default Handler")));
void HardFault_handler(void)   __attribute__((weak, alias("default_handler")));
extern void NMI_handler(void);


__attribute__((section(".isr_vectors")))
const uint32_t vector_table[] = {
    STACK_START,                // Initial stack pointer value (for demonstration purposes)
    (uint32_t)&reset_handler, // Reset handler address
    (uint32_t)&NMI_handler,
    (uint32_t)&HardFault_handler
    //Here we can have other vectors and Isr address
};

// Intialized data
uint32_t dummy_init_data = 0x122;

// un-initilized data
uint32_t dummy_no_init_data;

// Reset handler function
void reset_handler(void) {
    uint32_t r1 = 0x1;
    uint32_t r2 = 0x2;
    uint32_t r3 = r1 + r2;
    while (1) {

    }
}
void default_handler(void)
{
    while(1);
    // Does nothing
}

int main(void) {
    // Main function will not be called here
    while (1) {
    }
    return 0;
}