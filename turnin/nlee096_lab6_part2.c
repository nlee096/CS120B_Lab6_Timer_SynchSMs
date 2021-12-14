/*	Author: Nathan Lee
 *  Partner(s) Name: none
 *	Lab Section: 022
 *	Assignment: Lab #6  Exercise #2
 *	Exercise Description: 
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *  Demo Link: https://drive.google.com/drive/folders/1RU9OjELXQIDIOebR360i2dt0zOrjK6We?usp=sharing
 *
 */

#include <avr/io.h>
#include "timer.h"
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpB = 0x00;
unsigned char curr_light = 0x00;
unsigned char i = 0x00 ;
unsigned char tmpA = 0x00;
unsigned char light[4] = {0x01, 0x02, 0x04, 0x02};

enum States {Start, NEXT, Hold, Release, Hold_R} state;
void Tick(){
    switch(state){
        case Start:
            tmpB = 0x00;
            curr_light = 0x00;
            i = 0x00;
            state = NEXT;
            break;
        case NEXT:
            if((tmpA & 0x01) == 1){
                state = Hold;
            }
            else{
                state = NEXT;
            }
            break;
        case Hold:
            if((tmpA & 0x01) == 1){
                state = Hold;
            }
            else if((tmpA & 0x01) == 0){
                state = Release;
            }
            break;
        case Release:
            if((tmpA & 0x01) == 0){
                state = Release;
            }
            else if((tmpA & 0x01) == 1){
                state = Hold_R;
            }
            break;
        case Hold_R:
            if((tmpA & 0x01) == 1){
                state = Hold_R;
            }
            if((tmpA & 0x01) == 0){
                i = 0;
                curr_light = 0;
                state = NEXT;
            }
            break;
        default:
        break;
    }

    switch(state){
        case NEXT:
            i++;
            if(i > 3){
                i = 1;
                curr_light ++;
                if(curr_light >= 4){
                    curr_light = 0;
                }
            }
            tmpB = light[curr_light];
            break;
        default:
        break; 
    }
}


int main(void) {
    /* Insert DDR and PORT initializations */
    DDRA = 0x00; PORTA = 0xFF;
    DDRB = 0xFF; PORTB = 0x00;
    TimerSet(100);
    TimerOn();
    tmpB = 0x00;
    curr_light = 0x00;
    i = 0x00;
    tmpA = 0x00;
    state = Start;
    /* Insert your solution below */
    while (1) {
        tmpA = ~PINA;
        Tick();
        PORTB = tmpB;
        while(!TimerFlag);
        TimerFlag = 0;
    }
    //return 1;
}
