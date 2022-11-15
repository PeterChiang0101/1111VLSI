.FullAdder

.protect
.lib '/cad/cell_lib/cic018.l' tt
.endl '/cad/cic018.l'

.unprotect
.option post captab accurate
.temp 25

.global Vdd Vss
Vdd Vdd 0 dc 3.3
Vss Vss 0 dc 0
Vx0 x0 Vss pulse(0v Von 0.1n 0.1n 0.5n 1.2n)
Vx1 x1 Vss pulse(0v Von 0.1n 0.1n 0.5n 1.2n)
Vx2 x2 Vss pulse(0v Von 0.1n 0.1n 0.5n 1.2n)
Vy0 y0 Vss pulse(0v Von 0.1n 0.1n 0.5n 1.2n)
Vy1 y1 Vss pulse(0v Von 0.1n 0.1n 0.5n 1.2n)
Vy2 y2 Vss pulse(0v Von 0.1n 0.1n 0.5n 1.2n)
Vc0 c0 Vss pulse(0v Von 0.1n 0.1n 0.5n 1.2n) 
.param Von = 3.3v

.op
.tran 50p 100n
.probe V(S0) V(S1) V(S2) V(Cout)

XFA0 x0 y0 c0 S0 c1
XFA1 x1 y1 c1 S1 c2
XFA2 x2 y2 c2 S2 Cout


.subckt INV In Out
Mp1 Out In Vdd Vdd p_18 w=2u l=0.18u
Mn1 Out In Vss Vss n_18 w=1u l=0.18u
.ends INV

.subckt XOR In1 In2 Out
Xinva In1 invIn1 INV
Xinvb In2 invIn2 INV

Mp1 P1 In1 Vdd Vdd p_18 w=2u l=0.18u
Mp2 P1 In2 Vdd Vdd p_18 w=2u l=0.18u
Mp3 Out invIn1 P1 P1 p_18 w=2u l=0.18u
Mp4 Out invIn2 P1 P1 p_18 w=2u l=0.18u

Mn1 Out invIn1 N1 N1 n_18 w=1u l=0.18u
Mn2 N1 invIn2 Vss Vss n_18 w=1u l=0.18u
Mn3 Out In1 N2 N2 n_18 w=1u l=0.18u
Mn4 N2 In2 Vss Vss n_18 w=1u l=0.18u
.ends XOR

.subckt AND In1 In2 Out
Mp1 Outinv In1 Vdd Vdd p_18 w=2u l=0.18u
Mp2 Outinv In2 Vdd Vdd p_18 w=2u l=0.18u
Mn1 Outinv In1 N1 N1 n_18 w=1u l=0.18u
Mn2 N1 In2 Vss Vss n_18 w=1u l=0.18u

Xinv Outinv Out INV
.ends AND

.subckt OR In1 In2 Out
Mp1 P1 In1 Vdd Vdd p_18 w=2u l=0.18u
Mp2 Outinv In2 P1 P1 p_18 w=2u l=0.18u

Mn1 Outinv In1 Vss Vss n_18 w=1u l=0.18u
Mn2 Outinv In2 Vss Vss n_18 w=1u l=0.18u

Xinv Outinv Out INV
.ends OR

.subckt FullAdder A B Cin S Cout
Xxor1 x0 y0 Out1 XOR
Xxor2 Out1 Cin S XOR
Xand1 Out1 Cin Out2 AND
Xand2 x0 y0 Out3 AND
Xor3 Out2 Out3 Cout OR
.ends FullAdder

.end