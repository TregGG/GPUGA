// =============================================================================
// gpu_pkg.sv — Shared constants and types for DE0-Nano GPU
// =============================================================================
// This package contains all timing parameters, screen dimensions, color
// definitions, and command opcodes used across the GPU design.
// =============================================================================

package gpu_pkg;

    // =========================================================================
    // Clock frequencies
    // =========================================================================
    parameter CLK_FREQ_HZ    = 50_000_000;  // DE0-Nano 50 MHz oscillator
    parameter PIXEL_CLK_HZ   = 25_000_000;  // VGA 640x480 @ 60Hz pixel clock

    // =========================================================================
    // VGA 640x480 @ 60Hz timing parameters
    // =========================================================================
    // Horizontal timing (in pixel clocks)
    parameter H_VISIBLE      = 640;
    parameter H_FRONT_PORCH  = 16;
    parameter H_SYNC_PULSE   = 96;
    parameter H_BACK_PORCH   = 48;
    parameter H_TOTAL        = H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH; // 800

    // Vertical timing (in lines)
    parameter V_VISIBLE      = 480;
    parameter V_FRONT_PORCH  = 10;
    parameter V_SYNC_PULSE   = 2;
    parameter V_BACK_PORCH   = 33;
    parameter V_TOTAL        = V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH; // 525

    // Sync polarity (active low for 640x480)
    parameter H_SYNC_ACTIVE  = 1'b0;
    parameter V_SYNC_ACTIVE  = 1'b0;

    // =========================================================================
    // Screen and color parameters
    // =========================================================================
    parameter SCREEN_WIDTH   = H_VISIBLE;   // 640
    parameter SCREEN_HEIGHT  = V_VISIBLE;   // 480
    parameter COLOR_DEPTH    = 8;           // 8-bit palette index
    parameter DAC_BITS       = 4;           // 4-bit per channel R-2R DAC
    parameter PALETTE_SIZE   = 256;         // 256-entry color palette

    // =========================================================================
    // Framebuffer parameters (for future phases)
    // =========================================================================
    parameter FB_ADDR_WIDTH  = 19;          // ceil(log2(640*480)) = 19 bits
    parameter FB_SIZE        = SCREEN_WIDTH * SCREEN_HEIGHT; // 307,200 bytes

    // =========================================================================
    // GPU command opcodes (for future phases)
    // =========================================================================
    parameter CMD_SYNC       = 8'hAA;       // Sync byte prefix
    parameter CMD_CLEAR      = 8'h01;
    parameter CMD_PIXEL      = 8'h02;
    parameter CMD_LINE       = 8'h03;
    parameter CMD_RECT       = 8'h04;
    parameter CMD_FILL_RECT  = 8'h05;
    parameter CMD_CIRCLE     = 8'h06;
    parameter CMD_FILL_CIRCLE= 8'h07;
    parameter CMD_SET_PALETTE= 8'h08;
    parameter CMD_SWAP_BUFFER= 8'h09;

endpackage
