#include <stdio.h>
#include <stdint.h>

// com ports addresses
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
static inline void printToPort(uint16_t port, uint8_t arg){
    __asm__ volatile("outb %0,%w1;":: "a"(arg), "Nd"(port));
}
static inline uint8_t readFromPort(uint16_t port){
    uint8_t ret;
    __asm__ volatile("inb %w1,%0;": "=a" (ret): "Nd" (port));
    return ret;
}

// initializing 
static int init(uint16_t port, uint8_t *speed){
    printToPort(port+1, 0);
    return 0;
}

int main(){
    uint16_t port = COM1;
    uint8_t speed[] = bps9600;
    printf("Start init for %d\n",port);
    int res = init(port, speed);
    if(res != 0){
        printf("some thing goes wrong");
        return 1;
    }
    printf("UART initialized\n");

    return 0;
}