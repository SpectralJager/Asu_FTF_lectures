#include <stdio.h>
#include <stdint.h>

extern void init();
#pragma aux init = \
    "xor ax, ax" \
    "mov dx, 0x0" \
    "mov al, 0xfb" \
    "int 14h";

extern uint16_t recive();
#pragma aux recive = \
    "mov dx, 0x0" \
    "mov ah, 0x2" \
    "int 14h" \
    parm [al] \
    value [ax];

extern void print(uint8_t ch);
#pragma aux print = \
    "xor ax, ax" \
    "mov ah, 02h" \
    "int 21h" \
    parm [dl];

void transmit(){
    printf("Start reciving from com1...\n");
    while (1) {
        uint16_t result = recive();
        if ((result & 0xff00) != 0) {
            continue;
        }
        print(result & 0xff);
    }
}

int main(void){
    init();
    printf("Port com1 initialized...\n");
    transmit();
    return 0;
}