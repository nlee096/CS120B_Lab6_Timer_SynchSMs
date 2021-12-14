/*	Author: Nathan Lee
 *  Partner(s) Name: none
 *	Lab Section: 022
 *	Assignment: Lab #6  Exercise #1
 *	Exercise Description: lights alternate 0,1,2,0,1,2
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *  Demo Link: https://drive.google.com/drive/folders/1Ccl5XMBhWsTSyn9BjzhlwCEKyVEmBVXL?usp=sharing
 *
 */

#include <avr/io.h>
#include "timer.h"
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpB;
unsigned char cnt;

enum States {Start, ON} state;
void Tick(){
    switch(state){
        case Start:
            tmpB = 0x01;
            cnt = 0x00;
            state = ON;
            break;
        case ON:
            if(tmpB > 0x02){
                tmpB = 0x01;
            }
            else{
                tmpB = tmpB <<1;
            }
            state = ON;
            break;
        default:
        break;
    }
}


int main(void) {
    /* Insert DDR and PORT initializations */
    DDRB = 0xFF; PORTB = 0x00;
    TimerSet(1000);
    TimerOn();
    tmpB = 0x00;
    cnt = 0x00;
    /* Insert your solution below */
    while (1) {
        //tmpB = ~tmpB;
        Tick();
        PORTB = tmpB;
        while(!TimerFlag);
        TimerFlag = 0;
    }
    return 1;
}
