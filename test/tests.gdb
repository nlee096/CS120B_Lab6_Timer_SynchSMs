# Test file for "lab6_Timer_SynchSMs"


# commands.gdb provides the following functions for ease:
#   test "<message>"
#       Where <message> is the message to print. Must call this at the beginning of every test
#       Example: test "PINA: 0x00 => expect PORTB: 0x01"
#   checkResult
#       Verify if the test passed or failed. Prints "passed." or "failed." accordingly, 
#       Must call this at the end of every test.
#   expectPORTx <val>
#       With x as the port (A,B,C,D)
#       The value the port is epected to have. If not it will print the erroneous actual value
#   setPINx <val>
#       With x as the port or pin (A,B,C,D)
#       The value to set the pin to (can be decimal or hexidecimal
#       Example: setPINA 0xFE
#   printPORTx f OR printPINx f 
#       With x as the port or pin (A,B,C,D)
#       With f as a format option which can be: [d] decimal, [x] hexadecmial (default), [t] binary 
#       Example: printPORTB d
#   printDDRx
#       With x as the DDR (A,B,C,D)
#       Example: printDDRB

echo ======================================================\n
echo Running all tests..."\n\n

# Example test:
#test "PINA: 0x00, PINB: 0x00 => PORTB: 0"
# Set inputs
#setPINA 0xFF
#setPINB 0x00
# Continue for several ticks
#continue 2
# Set expect values
#expectPORTB 0
# Check pass/fail
#checkResult

# Add tests below

test "PINA: 0x00 =>  PORTB: 0x07"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
# Set expect values
expectPORTB 0x07
# Check pass/fail
checkResult
expect state WAIT

test "PINA: 0x00 0x03 =>  PORTB: 0x00"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFC
continue 1
# Set expect values
expectPORTB 0x00
# Check pass/fail
checkResult
expect state RESET

test "PINA: 0x00 0x03 0x01 0x01 0x01 =>  PORTB: 0x01"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFC
continue 1
setPINA 0xFE
continue 3
# Set expect values
expectPORTB 0x01
# Check pass/fail
checkResult
expect state A0_PRESS

test "PINA: 0x00 0x03 0x02 0x02 0x02 =>  PORTB: 0x00"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFC
continue 1
setPINA 0xFD
continue 3
# Set expect values
expectPORTB 0x00
# Check pass/fail
checkResult
expect state A1_PRESS

test "PINA: 0x00 0x03 0x02 0x01 0x02 =>  PORTB: 0x00"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFC
continue 1
setPINA 0xFD
continue 1
setPINA 0xFE
continue 1
setPINA 0xFD
continue 1
# Set expect values
expectPORTB 0x00
# Check pass/fail
checkResult
expect state A1_PRESS

test "PINA: 0x00 0x03 0x00 =>  PORTB: 0x00"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFC
continue 1
setPINA 0xFF
continue 1
# Set expect values
expectPORTB 0x00
# Check pass/fail
checkResult
expect state WAIT

test "PINA: 0x00 0x01 =>  PORTB: 0x08"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
# Set expect values
expectPORTB 0x08
# Check pass/fail
checkResult
expect state A0_PRESS

test "PINA: 0x00 0x01 0x01 0x01 0x01=>  PORTB: 0x08"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
setPINA 0xFE
continue 1
setPINA 0xFE
continue 1
setPINA 0xFE
continue 1
# Set expect values
expectPORTB 0x08
# Check pass/fail
checkResult
expect state A0_PRESS

test "PINA: 0x00 0x01 0x00 =>  PORTB: 0x08"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
setPINA 0xFF
continue 1
# Set expect values
expectPORTB 0x08
# Check pass/fail
checkResult
expect state WAIT

test "PINA: 0x00 0x01 0x00 0x01 0x00 0x01 0x00 0x01 0x00=>  PORTB: 0x09"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
setPINA 0xFF
continue 1
# Set expect values
expectPORTB 0x09
# Check pass/fail
checkResult
expect state WAIT

test "PINA: 0x00 0x01 0x02 =>  PORTB: 0x07"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
setPINA 0xFD
continue 1
# Set expect values
expectPORTB 0x07
# Check pass/fail
checkResult
expect state A1_PRESS

test "PINA: 0x00 0x01 0x03 =>  PORTB: 0x00"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFE
continue 1
setPINA 0xFC
continue 1
# Set expect values
expectPORTB 0x00
# Check pass/fail
checkResult
expect state RESET

test "PINA: 0x00 0x02 =>  PORTB: 0x06"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
# Set expect values
expectPORTB 0x06
# Check pass/fail
checkResult
expect state A1_PRESS

test "PINA: 0x00 0x02 0x02 0x02 0x02=>  PORTB: 0x06"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFD
continue 1
setPINA 0xFD
continue 1
setPINA 0xFD
continue 1
# Set expect values
expectPORTB 0x06
# Check pass/fail
checkResult
expect state A1_PRESS

test "PINA: 0x00 0x02 0x00 =>  PORTB: 0x06"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
# Set expect values
expectPORTB 0x06
# Check pass/fail
checkResult
expect state WAIT

test "PINA: 0x00 0x02 0x00 0x02 0x00 0x02 0x00 0x02 0x00 0x02 0x00 0x02 0x00 0x02 0x00 0x02 0x00 0x02 0x00 =>  PORTB: 0x09"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFF
continue 1
# Set expect values
expectPORTB 0x00
# Check pass/fail
checkResult
expect state WAIT

test "PINA: 0x00 0x02 0x01 =>  PORTB: 0x07"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFE
continue 1
# Set expect values
expectPORTB 0x07
# Check pass/fail
checkResult
expect state A0_PRESS

test "PINA: 0x00 0x02 0x03 =>  PORTB: 0x00"
# Set inputs
set state = Start
setPINA 0xFF
continue 1
setPINA 0xFD
continue 1
setPINA 0xFC
continue 1
# Set expect values
expectPORTB 0x00
# Check pass/fail
checkResult
expect state RESET

test "PINA: 0x00 0x03 0x01 for 9 second => PORTB: 0x09"
# Set inputs
set state = Start
setPINA 0xFC
continue 1
setPINA 0xFE
continue 90
# Set expect values
expectPORTB 0x09
# Check pass/fail
checkResult
expect state A0_PRESS

test "PINA: 0x02 for 9 second => PORTB: 0x00"
# Set inputs
setPINA 0xFD
continue 90
# Set expect values
expectPORTB 0x00
# Check pass/fail
checkResult
expect state A1_PRESS


# Report on how many tests passed/tests ran
set $passed=$tests-$failed
eval "shell echo Passed %d/%d tests.\n",$passed,$tests
echo ======================================================\n
