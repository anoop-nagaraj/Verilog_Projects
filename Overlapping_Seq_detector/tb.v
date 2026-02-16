`timescale 1ns / 1ps

module fsm_tb;

    // Inputs
    reg clk;
    reg rst;
    reg din;

    // Output
    wire dout;

    // Instantiate the FSM
    fsm uut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .dout(dout)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        din = 0;

        // Apply reset
        #20;
        rst = 0;

        // Test sequence
        // 1) No consecutive 1s
        #10 din = 0;
        #10 din = 1;
        #10 din = 0;

        // 2) Two consecutive 1s (should NOT set dout)
        #10 din = 1;
        #10 din = 1;
        #10 din = 0;

        // 3) Three consecutive 1s (should set dout = 1)
        #10 din = 1;
        #10 din = 1;
        #10 din = 1;

        // 4) More than three 1s (dout should stay 1)
        #10 din = 1;
        #10 din = 1;

        // 5) Break sequence
        #10 din = 0;

        // Finish simulation
        #20;
//        $stop;
    end

endmodule
