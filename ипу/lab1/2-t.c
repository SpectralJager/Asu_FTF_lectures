#include <stdio.h>
#include <stdint.h>

extern void init();
#pragma aux init = \
    "xor ax, ax" \
    "mov dx, 0x0" \
    "mov al, 0xfb" \
    "int 14h";

extern uint8_t send(uint8_t ch);
#pragma aux send = \
    "mov dx, 0x0" \
    "mov ah, 0x1" \
    "int 14h" \
    parm [al] \
    value [ah];

extern uint8_t scan();
#pragma aux scan = \
    "xor ax, ax" \
    "mov ah, 01h" \
    "int 21h" \
    value [al];

void transmit(){
    printf("Start transmission to com1...\n");
    while (1) {
        uint8_t ch = scan();
        if (ch == '\r') {
            printf("\n");
            send('\n');
            continue;
        }
        send(ch);
    }
}

int main(void){
    init();
    printf("Port com1 initialized...\n");
    transmit();
    return 0;
}