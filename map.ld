MEMORY
{
    FLASH(rx) : ORIGIN = 0X8000000, LENGTH = 0X20000
    SRAM(rw) : ORIGIN = 0X20000000, LENGTH = 0X2000
}
__max_heap_size = 0x400;
__max_stack_size = 0x200;

SECTIONS
{
    .text : {
        *(.isr_vectors*)
        *(.text*)
        end_of_text = .;
    } > FLASH

    .data : {
        start_of_data = .;
        *(.data*)
        end_of_data = .;
    } > SRAM AT> FLASH

    .bss : {
        start_of_bss = .;
        *(.bss*)
        end_of_bss = .;
    } > SRAM
}