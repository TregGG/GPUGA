// =============================================================================
// vga_test_pattern.sv — Generates color bar test pattern
// =============================================================================
// Produces 8 vertical color bars across the screen. Each bar is 80 pixels
// wide (640 / 8 = 80). Colors go through a standard test sequence.
//
// This module outputs 4-bit per channel RGB directly to the R-2R DAC.
// In later phases, this module will be replaced by the framebuffer read path.
// =============================================================================

module vga_test_pattern
    import gpu_pkg::*;
(
    input  logic        pixel_clk,     // 25 MHz pixel clock
    input  logic [9:0]  pixel_x,       // Current horizontal pixel position
    input  logic [8:0]  pixel_y,       // Current vertical pixel position
    input  logic        video_active,  // HIGH when in visible area

    // 4-bit per channel RGB output (directly drives R-2R DAC via GPIO)
    output logic [3:0]  vga_r,         // Red channel (4 bits)
    output logic [3:0]  vga_g,         // Green channel (4 bits)
    output logic [3:0]  vga_b          // Blue channel (4 bits)
);

    // =========================================================================
    // Color bar definitions — 12-bit RGB (4 bits per channel)
    // =========================================================================
    // Standard 8-bar test pattern:
    //   White, Yellow, Cyan, Green, Magenta, Red, Blue, Black
    logic [11:0] bar_colors [8];

    assign bar_colors[0] = 12'hFFF;    // White
    assign bar_colors[1] = 12'hFF0;    // Yellow
    assign bar_colors[2] = 12'h0FF;    // Cyan
    assign bar_colors[3] = 12'h0F0;    // Green
    assign bar_colors[4] = 12'hF0F;    // Magenta
    assign bar_colors[5] = 12'hF00;    // Red
    assign bar_colors[6] = 12'h00F;    // Blue
    assign bar_colors[7] = 12'h000;    // Black

    // =========================================================================
    // Determine which color bar the current pixel falls in
    // =========================================================================
    // Divide screen into 8 equal bars: pixel_x / 80 = bar index
    // Using bit shift: pixel_x[9:0] / 80 is not a power of 2,
    // so we use pixel_x[9:4] / 5 or simpler: check ranges
    logic [2:0] bar_index;
    logic [11:0] current_color;

    always_comb begin
        // Each bar is 80 pixels wide (640 / 8 = 80)
        if (pixel_x < 10'd80)
            bar_index = 3'd0;
        else if (pixel_x < 10'd160)
            bar_index = 3'd1;
        else if (pixel_x < 10'd240)
            bar_index = 3'd2;
        else if (pixel_x < 10'd320)
            bar_index = 3'd3;
        else if (pixel_x < 10'd400)
            bar_index = 3'd4;
        else if (pixel_x < 10'd480)
            bar_index = 3'd5;
        else if (pixel_x < 10'd560)
            bar_index = 3'd6;
        else
            bar_index = 3'd7;

        current_color = bar_colors[bar_index];
    end

    // =========================================================================
    // Output RGB — only drive color during active video, black during blanking
    // =========================================================================
    always_comb begin
        if (video_active) begin
            vga_r = current_color[11:8];
            vga_g = current_color[7:4];
            vga_b = current_color[3:0];
        end else begin
            // Must output black during blanking periods
            vga_r = 4'h0;
            vga_g = 4'h0;
            vga_b = 4'h0;
        end
    end

endmodule
