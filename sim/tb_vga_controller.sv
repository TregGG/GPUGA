// =============================================================================
// tb_vga_controller.sv — Testbench for VGA timing verification
// =============================================================================
// Verifies that the VGA controller produces correct timing for 640x480 @ 60Hz.
//
// Expected timing at 25 MHz pixel clock:
//   Horizontal line period: 800 pixels × 40 ns = 32,000 ns (31.25 kHz)
//   Vertical frame period:  525 lines × 32,000 ns = 16,800,000 ns (~59.52 Hz)
//   HSYNC pulse width:      96 pixels × 40 ns = 3,840 ns
//   VSYNC pulse width:      2 lines × 32,000 ns = 64,000 ns
// =============================================================================

`timescale 1ns / 1ps

module tb_vga_controller;

    // =========================================================================
    // Clock and reset
    // =========================================================================
    logic pixel_clk;
    logic reset_n;

    // VGA controller outputs
    logic        hsync;
    logic        vsync;
    logic [9:0]  pixel_x;
    logic [8:0]  pixel_y;
    logic        video_active;

    // =========================================================================
    // Clock generation — 25 MHz (40 ns period)
    // =========================================================================
    initial pixel_clk = 1'b0;
    always #20 pixel_clk = ~pixel_clk;  // 40 ns period = 25 MHz

    // =========================================================================
    // DUT — Device Under Test
    // =========================================================================
    vga_controller dut (
        .pixel_clk    (pixel_clk),
        .reset_n      (reset_n),
        .hsync        (hsync),
        .vsync        (vsync),
        .pixel_x      (pixel_x),
        .pixel_y      (pixel_y),
        .video_active (video_active)
    );

    // =========================================================================
    // Timing measurement variables
    // =========================================================================
    realtime hsync_fall_time, hsync_rise_time;
    realtime vsync_fall_time, vsync_rise_time;
    realtime h_line_start, h_line_period;
    realtime v_frame_start, v_frame_period;
    int      hsync_pulse_count;
    int      vsync_pulse_count;
    int      active_pixel_count;
    int      active_line_count;

    // =========================================================================
    // Monitor HSYNC transitions
    // =========================================================================
    always @(negedge hsync) begin
        hsync_fall_time = $realtime;
        if (hsync_pulse_count > 0) begin
            h_line_period = hsync_fall_time - h_line_start;
        end
        h_line_start = hsync_fall_time;
        hsync_pulse_count++;
    end

    always @(posedge hsync) begin
        hsync_rise_time = $realtime;
    end

    // =========================================================================
    // Monitor VSYNC transitions
    // =========================================================================
    always @(negedge vsync) begin
        vsync_fall_time = $realtime;
        if (vsync_pulse_count > 0) begin
            v_frame_period = vsync_fall_time - v_frame_start;
        end
        v_frame_start = vsync_fall_time;
        vsync_pulse_count++;
    end

    always @(posedge vsync) begin
        vsync_rise_time = $realtime;
    end

    // =========================================================================
    // Test sequence
    // =========================================================================
    initial begin
        $display("========================================");
        $display("VGA Controller Testbench");
        $display("Expected: 640x480 @ 60Hz, 25 MHz pixel clock");
        $display("========================================");

        // Initialize
        reset_n = 1'b0;
        hsync_pulse_count = 0;
        vsync_pulse_count = 0;

        // Hold reset for 10 clock cycles
        repeat (10) @(posedge pixel_clk);
        reset_n = 1'b1;
        $display("[%0t] Reset released", $realtime);

        // Wait for 2 complete frames (enough to measure timing)
        // 2 frames = 2 × 525 × 800 = 840,000 pixel clocks = 33,600,000 ns
        repeat (840_000) @(posedge pixel_clk);

        // =====================================================================
        // Report results
        // =====================================================================
        $display("");
        $display("========================================");
        $display("Timing Measurements:");
        $display("========================================");
        $display("  H line period:   %0t (expected: 32000 ns)", h_line_period);
        $display("  HSYNC pulses:    %0d (expected: ~1050 for 2 frames)", hsync_pulse_count);
        $display("  VSYNC pulses:    %0d (expected: 2)", vsync_pulse_count);

        if (v_frame_period > 0)
            $display("  V frame period:  %0t (expected: 16800000 ns)", v_frame_period);

        // =====================================================================
        // Verify timing is within tolerance
        // =====================================================================
        $display("");
        $display("========================================");
        $display("Verification:");
        $display("========================================");

        // Check horizontal period: should be 800 × 40ns = 32,000 ns
        if (h_line_period >= 31900 && h_line_period <= 32100)
            $display("  [PASS] Horizontal line period within tolerance");
        else
            $display("  [FAIL] Horizontal line period out of range: %0t", h_line_period);

        // Check vertical period: should be 525 × 32,000 ns = 16,800,000 ns
        if (v_frame_period >= 16_700_000 && v_frame_period <= 16_900_000)
            $display("  [PASS] Vertical frame period within tolerance");
        else
            $display("  [FAIL] Vertical frame period out of range: %0t", v_frame_period);

        // Check HSYNC pulse count
        if (hsync_pulse_count >= 1049 && hsync_pulse_count <= 1051)
            $display("  [PASS] HSYNC pulse count correct");
        else
            $display("  [FAIL] HSYNC pulse count: %0d", hsync_pulse_count);

        $display("");
        $display("========================================");
        $display("Testbench complete");
        $display("========================================");
        $finish;
    end

    // =========================================================================
    // Timeout watchdog — kill simulation if stuck
    // =========================================================================
    initial begin
        #40_000_000;   // 40 ms should be enough for 2 frames
        $display("[ERROR] Simulation timed out!");
        $finish;
    end

    // =========================================================================
    // Optional: dump waveforms for GTKWave / ModelSim
    // =========================================================================
    initial begin
        $dumpfile("vga_controller.vcd");
        $dumpvars(0, tb_vga_controller);
    end

endmodule
