.text
main_loop:
<BODY>
</BODY>
jmp main_loop
shift_memory:
feedforward:
ldx G %N ; G = i_0 = n
ldi A 0x00
push A ;    push(low(y))
push A ;    push(high(y))
ff_loop:
ldi A %X0
mov B G
add
lda C ; C = x[i]
ldi A %W0
mov B G
add
lda D ; D = w[i]
mov A C
mov B D 
mullo
push A ; push low(x*w)
mov A C 
mulhi
push A ; push high(x*w)
pop D ; D = high(x*w)
pop C ; C = low(x*w)
pop B ; B = low(y)
mov A C 
add 
mov C A; C = low(y) + low(x*w) (clamp to max signed value somehow)
pop B ; B = high(y)
mov A D
adc
mov D A ; D = high(y) + high(x*w) + carry (ditto)
push D ; push high(y)
push C ; push low(y)

mov A G
dec
mov G A
jnc ff_loop
;y_high = high(y)
ret

.data
y_high = 0
hits = 0
games = 0
gamma = 22
n = 19
W0 = 0x01
W1 = 0x01
W3 = 0x01
W4 = 0x01
W5 = 0x01
W6 = 0x01
W7 = 0x01
W8 = 0x01
W9 = 0x01
W10 = 0x01
W11 = 0x01
W12 = 0x01
W13 = 0x01
W14 = 0x01
W15 = 0x01
W16 = 0x01
W17 = 0x01
W18 = 0x01
W19 = 0x01
X0 = 0x01
X1 = 0x01
X2 = 0x01
X3 = 0x01
X4 = 0x01
X5 = 0x01
X6 = 0x01
X7 = 0x01
X8 = 0x01
X9 = 0x01
X10 = 0x01
X11 = 0x01
X12 = 0x01
X13 = 0x01
X14 = 0x01
X15 = 0x01
X16 = 0x01
X17 = 0x01
X18 = 0x01
X19 = 0x01