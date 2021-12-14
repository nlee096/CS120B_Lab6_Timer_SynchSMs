/*	Author: Nathan Lee
 *  Partner(s) Name: none
 *	Lab Section: 022
 *	Assignment: Lab #6  Exercise #2
 *	Exercise Description: 
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *  Demo Link: https://drive.google.com/drive/folders/1UwWIdynYMCFZlpAZAHEP_rELiiLoh27v?usp=sharing
 *
 */

#include <avr/io.h>
#include "timer.h"
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

enum States {Start, WAIT, A0_PRESS, A1_PRESS, RESET} state;
unsigned char tempA;
unsigned char cnt;
unsigned char secWait;

void Tick(){
    switch(state){ // Transitions...
        case Start:
            cnt = 0x07;
            secWait = 0;
            state = WAIT;
            break;
        case WAIT:
            secWait = 0;
            if(tempA == 0x00){
                state = WAIT;
            }
            else if(tempA == 0x03){
                cnt = 0x00;
                state = RESET;
            }
            else if(tempA == 0x01){
                cnt = (cnt<9)? (cnt+1) :  0x09;
                state = A0_PRESS;
            }
            else if(tempA == 0x02){
                cnt = (cnt>0)? (cnt-1) :  0x00;
                state = A1_PRESS;
            }
            break;
        case A0_PRESS:
            if(tempA == 0x00){
                secWait = 0;
                state = WAIT;
            }
            else if(tempA == 0x03){
                cnt = 0x00;
                state = RESET;
            }
            else if(tempA == 0x01){
                state = A0_PRESS;
            }
            else if(tempA == 0x02){
                cnt = (cnt>0)? (cnt-1) :  0x00;
                state = A1_PRESS;
            }
            break;
        case A1_PRESS:
            if(tempA == 0x00){
                secWait = 0;
                state = WAIT;
            }
            else if(tempA == 0x03){
                cnt = 0x00;
                state = RESET;
            }
            else if(tempA == 0x01){
                cnt = (cnt<9)? (cnt+1) :  0x09;
                state = A0_PRESS;
            }
            else if(tempA == 0x02){
                state = A1_PRESS;
            }
            break;
        case RESET:
            if(tempA == 0x00){
                state = WAIT;
            }
            else if(tempA == 0x03){
                cnt = 0x00;
                state = RESET;
            }
            else if(tempA == 0x01){
                cnt = (cnt<9)? (cnt+1) :  0x09;
                state = A0_PRESS;
            }
            else if(tempA == 0x02){
                cnt = (cnt>0)? (cnt-1) :  0x00;
                state = A1_PRESS;
            }
        default:
            break;

    } 
    switch(state){
        case A0_PRESS:
            secWait++;
            if(secWait >= 10){
                cnt = (cnt<9)? (cnt+1) :  0x09;
                secWait = 0;
            }
            break;
        case A1_PRESS:
            secWait++;
            if(secWait >= 10){
                cnt = (cnt>0)? (cnt-1) :  0x00;
                secWait = 0;
            }
            break;

    }
}


int main(void) {
    /* Insert DDR and PORT initializations */
    DDRA = 0x00; PORTA = 0xFF;
    DDRB = 0xFF; PORTB = 0x00;
    TimerSet(100);
    TimerOn();
    cnt = 0x00;
    tempA = 0x00;
    secWait = 0x00;
    state = Start;
    /* Insert your solution below */
    while (1) {
        tempA = ~PINA;
        Tick();
        PORTB = cnt;
        while(!TimerFlag);
        TimerFlag = 0;
    }
    return 1;
}
