# AWGN_Generator
﻿
In the current state the project satisfies the 10ns clk period timing constraint and is accurate to +- 1 lsb from the "infinite precision" simulation

The 300Mhz requirement could be satisfied with the addition of extra pipeline stages

AWGN_FINAL.v is AWGN.v with pipeline stages added to pass the timing constraint
logp.v is log.v with pipeline stages

AWGN.v will pass the testbench, AWGN_FINAL.v will not as the URNG outputs u1 and u0 used in simulation wind up offset due to a different number of pipeline stages in their respective paths
which affects the value of the noise samples but not their validity










