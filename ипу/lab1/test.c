#include <windows.h>
#include <stdio.h>
#include <conio.h>

BOOL init(HANDLE handler) {
    DCB settings;
    COMMTIMEOUTS timeouts = {0xFFFFFFFF,0,0,0,1500};

    if(!GetCommState(handler, &settings)){
       printf("Err: Cant get port settings...");
       return FALSE;
    }
    settings.BaudRate = CBR_9600;
    settings.ByteSize = 8;
    settings.Parity = EVENPARITY;
    settings.StopBits = ONESTOPBIT;
    if(!SetCommState(handler, &settings)) {
        printf("Err: Cant safe port settings...");
        return FALSE;
    }
    printf("Successfully set settings for port...\n");

    /*if(!SetCommTimeouts(handler, &timeouts)){
        printf("Err: Cant set timeouts...");
        return FALSE;
    }*/

    return TRUE;
}

BOOL writeSYNC(HANDLE handler) {
    char buffer[1];
    char ch = 0x0;
    int writenBytes = 0;
    printf("Enter char to send (ESC for EXIT):\n");
    while(1) {
        ch = getch();
        if (ch == 0x1B){
            return TRUE;
        }
        strcpy(buffer, &ch);
        if(WriteFile(handler, buffer, 1, (LPDWORD)&writenBytes, NULL)) {
            if(writenBytes == 0) {
                printf("Err: WriteFile timeout...");
                return FALSE;
            }
        } else {
            printf("Err: WriteFile failed...");
            return FALSE;
        }
    }
    return TRUE;
}

BOOL receiveSYNC(HANDLE handler) {
    char buffer[256] = {0x0};
    unsigned long readedBytes;
    printf("Receiving chars from port...\n");
    while(1) {
        if(!ReadFile(handler, buffer, 256, &readedBytes, NULL)) {
            printf("Err: ReadFile is failed...");
            return FALSE;
        }
        printf("%s", buffer);
        Sleep(100);
    }
    return TRUE;
}



int main() {
    HANDLE hPort;


    hPort = CreateFileA("\\\\.\\COM1", GENERIC_WRITE | GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);

    if(hPort == INVALID_HANDLE_VALUE) {
        printf("Err: Cant open port, invalid handle value.");
        goto exit;
    }
    printf("Opening port successful...\n");

    if(!init(hPort)) {
        goto clsHandler;
    }
    printf("Port successfully initialized...\n");

    printf("Select mode (WRITE=1, RECIVE=2): ");
    if(getchar() == '1') {
        if(!writeSYNC(hPort)) {
            goto clsHandler;
        }
    } else {
        if(!receiveSYNC(hPort)) {
            goto clsHandler;
        }
    }
    printf("\nDone! Bye bye!\n");

clsHandler:
    CloseHandle(hPort);
exit:
    return 0;
}
