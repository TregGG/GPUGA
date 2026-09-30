// =============================================================================
// top_level.sv — Top-level module for DE0-Nano GPU
// =============================================================================
// This is the pin-level module that maps directly to FPGA I/O pins.
// It instantiates the PLL, VGA controller, and test pattern generator,
// and routes the VGA signals to GPIO_0 header pins for the R-2R DAC.
//
// GPIO_0 Pin Allocation:
//   [0]  = R[3] (MSB)    [4]  = G[3] (MSB)    [8]  = B[3] (MSB)
//   [1]  = R[2]           [5]  = G[2]           [9]  = B[2]
//   [2]  = R[1]           [6]  = G[1]           [10] = B[1]
//   [3]  = R[0] (LSB)    [7]  = G[0] (LSB)    [11] = B[0] (LSB)
//   [12] = HSYNC          [13] = VSYNC
// =============================================================================

module top_level (
    // =========================================================================
    // Clock and reset
    // =========================================================================
    input  logic        CLOCK_50,      // 50 MHz onboard oscillator

    // =========================================================================
    // User I/O
    // =========================================================================
    input  logic [1:0]  KEY,           // Pushbuttons (active low, active = pressed)
    input  logic [3:0]  SW,            // DIP switches
    output logic [7:0]  LED,           // Green LEDs

    // =========================================================================
    // GPIO Header 0 — VGA R-2R DAC output
    // =========================================================================
    output logic [33:0] GPIO_0         // 34 GPIO pins (directly active pins)
);

    // =========================================================================
    // Internal signals
    // =========================================================================
    logic        pixel_clk;            // 25 MHz from PLL
    logic        pll_locked;           // PLL lock indicator
    logic        reset_n;              // Active-low reset (from KEY[0])

    // VGA controller outputs
    logic        hsync;
    logic        vsync;
    logic [9:0]  pixel_x;
    logic [8:0]  pixel_y;
    logic        video_active;

    // Test pattern RGB output
    logic [3:0]  vga_r;
    logic [3:0]  vga_g;
    logic [3:0]  vga_b;

    // =========================================================================
    // Reset logic
    // =========================================================================
    // KEY[0] is active-low (pressed = 0). Use it as reset.
    // Also require PLL to be locked before releasing reset.
    assign reset_n = KEY[0] & pll_locked;

    // =========================================================================
    // PLL — 50 MHz to 25 MHz
    // =========================================================================
    pll_25mhz u_pll (
        .clk_in  (CLOCK_50),
        .clk_out (pixel_clk),
        .locked  (pll_locked)
    );

    // =========================================================================
    // VGA Controller — generates timing signals
    // =========================================================================
    vga_controller u_vga (
        .pixel_clk    (pixel_clk),
        .reset_n      (reset_n),
        .hsync        (hsync),
        .vsync        (vsync),
        .pixel_x      (pixel_x),
        .pixel_y      (pixel_y),
        .video_active (video_active)
    );

    // =========================================================================
    // Test Pattern Generator — color bars (Phase 1, swapped in Phase 4)
    // =========================================================================
    vga_test_pattern u_test_pattern (
        .pixel_clk    (pixel_clk),
        .pixel_x      (pixel_x),
        .pixel_y      (pixel_y),
        .video_active (video_active),
        .vga_r        (vga_r),
        .vga_g        (vga_g),
        .vga_b        (vga_b)
    );

    // =========================================================================
    // GPIO_0 output mapping — directly to R-2R DAC on breadboard
    // =========================================================================
    // Red channel: GPIO_0[3:0] — MSB on [0], LSB on [3]
    // Wired so MSB (bit 3) is closest to VGA pin on R-2R ladder
    assign GPIO_0[0]  = vga_r[3];     // R MSB
    assign GPIO_0[1]  = vga_r[2];
    assign GPIO_0[2]  = vga_r[1];
    assign GPIO_0[3]  = vga_r[0];     // R LSB

    // Green channel: GPIO_0[7:4]
    assign GPIO_0[4]  = vga_g[3];     // G MSB
    assign GPIO_0[5]  = vga_g[2];
    assign GPIO_0[6]  = vga_g[1];
    assign GPIO_0[7]  = vga_g[0];     // G LSB

    // Blue channel: GPIO_0[11:8]
    assign GPIO_0[8]  = vga_b[3];     // B MSB
    assign GPIO_0[9]  = vga_b[2];
    assign GPIO_0[10] = vga_b[1];
    assign GPIO_0[11] = vga_b[0];     // B LSB

    // Sync signals: GPIO_0[13:12]
    assign GPIO_0[12] = hsync;
    assign GPIO_0[13] = vsync;

    // Unused GPIO pins driven low to avoid floating
    assign GPIO_0[33:14] = 20'd0;

    // =========================================================================
    // LED debug output
    // =========================================================================
    // Show PLL lock status and some debug info on LEDs
    assign LED[0] = pll_locked;        // PLL locked indicator
    assign LED[1] = reset_n;           // Reset released indicator
    assign LED[2] = hsync;             // Blinks at ~31 kHz (appears always on)
    assign LED[3] = vsync;             // Blinks at 60 Hz (appears always on)
    assign LED[7:4] = 4'b0000;        // Unused LEDs off

endmodule
