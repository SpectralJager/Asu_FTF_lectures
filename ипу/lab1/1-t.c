#include <stdio.h>
#include <stdint.h>

// common port addresses
#define COM1 0x3f8
#define COM2 0x2f8
#define COM3 0x3e8
#define COM4 0x2e8

// speed [bps] =    {low, hight}
#define bps115200   {0x01, 0x00} // div 1
#define bps57600    {0x02, 0x00} // div 2
#define bps38400    {0x03, 0x00} // div 3
#define bps19200    {0x06, 0x00} // div 6
#define bps9600     {0x0c, 0x00} // div 12
#define bps4800     {0x18, 0x00} // div 24
#define bps2400     {0x30, 0x00} // div 48
#define bps600      {0xc0, 0x00} // div 192
#define bps300      {0x80, 0x01} // div 384
#define bps50       {0x00, 0x09} // div 2304

// utils
extern void out(uint16_t port, uint8_t value);
#pragma aux out = \
    "out dx, al" \
    parm [dx] [al];

extern uint8_t in(uint16_t port);
#pragma aux in = \
    "in al, dx" \
    value [al] \
    parm [dx];

extern uint8_t gtch();
#pragma aux gtch = \
    "xor ax, ax" \
    "mov ah, 01h" \
    "int 21h" \
    value [al];

// init port
int initUart(uint16_t PORT, uint8_t* speed){
    out(PORT + 3, 0x80);    // Enable DLAB 
    out(PORT + 0, *speed);    // Set divisor (lo byte) 
    out(PORT + 1, *(speed + sizeof(uint8_t)));    //(hi byte)
    out(PORT + 3, 0x1b);    // 8 bits, no parity, one stop bit
    out(PORT + 1, 0x00);    // dissable interrupt
    out(PORT + 4, 0x1E);    // Set in loopback mode
    out(PORT + 0, 0xAE);    // send test signal 
    if(in(PORT) != 0xae){
        return 1;
    }
    out(PORT + 4, 0x00);
    return 0;
}

// wrinting functions
int isTransmitEmpty(uint16_t PORT) {
   return in(PORT + 5) & 0x20;
}
 
void writeToPort(uint16_t PORT, char a) {
   while (isTransmitEmpty(PORT) == 0);
   //printf("Transmit is empty\n");
   out(PORT,a);
}

void write(uint16_t PORT) {
    char ch = '0';
    printf("Begin transition, start typing text (for exit pres CTRC-c)\n");
    while (1){
        ch = gtch();
        if (ch == '\r') {
            printf("\n");
            out(PORT, '\n');
        }
        writeToPort(PORT, ch);
    }
}

int main(void) {   
    uint16_t PORT = COM1;
    uint8_t speed[2] = bps9600;

    if( initUart(PORT, speed) != 0 ){
        printf("Cant initialize UART for port [%x]\n", PORT);
        return 1;
    }
    printf("UART initialized successfully for port [%x]\n", PORT);

    write(PORT);

    return 0;
}