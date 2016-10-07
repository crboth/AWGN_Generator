# AWGN_Generator
﻿
This project impliments the Additive White Gaussian Noise Generator described in http://www.ee.usyd.edu.au/people/philip.leong/UserFiles/File/papers/bm_tc06.pdf  

AWGN_FINAL.v is AWGN.v with pipeline stages added to pass the timing constraint
logp.v is log.v with pipeline stages.

AWGN.v will pass the testbench, AWGN_FINAL.v will not as the URNG outputs u1 and u0 used in simulation wind up offset due to a different number of pipeline stages in their respective paths which affects the value of the noise samples but not their validity. Alternativly a seperate test set could be generated from the simulation taking this into account.

Vivado generates warnings regarding the recursive nature of the Leading Zero Detector, though these do not affect simulation.
Seperate warnings are generated regarding clk and half_clk and input and output timing but these issues are with the constraint set and not the validity of the RTL.










