// =============================================================================
// vga_controller.sv — VGA timing signal generator for 640x480 @ 60Hz
// =============================================================================
// Generates horizontal sync (hsync), vertical sync (vsync), pixel coordinates,
// and a video_active flag indicating when the beam is in the visible area.
//
// VGA 640x480 @ 60Hz timing:
//   Pixel clock: 25 MHz
//   Horizontal: 640 visible + 16 front porch + 96 sync + 48 back porch = 800
//   Vertical:   480 visible + 10 front porch +  2 sync + 33 back porch = 525
//   Sync polarity: active LOW for both hsync and vsync
// =============================================================================

module vga_controller
    import gpu_pkg::*;
(
    input  logic        pixel_clk,     // 25 MHz pixel clock
    input  logic        reset_n,       // Active-low reset

    // VGA sync outputs
    output logic        hsync,         // Horizontal sync (active low)
    output logic        vsync,         // Vertical sync (active low)

    // Pixel position outputs
    output logic [9:0]  pixel_x,       // Current horizontal pixel (0-639 when active)
    output logic [8:0]  pixel_y,       // Current vertical pixel (0-479 when active)
    output logic        video_active   // HIGH when in visible display area
);

    // =========================================================================
    // Internal counters
    // =========================================================================
    logic [9:0] h_count;    // Horizontal counter (0 to H_TOTAL-1 = 799)
    logic [9:0] v_count;    // Vertical counter (0 to V_TOTAL-1 = 524)

    // =========================================================================
    // Horizontal counter
    // =========================================================================
    // Counts pixels across each scanline. Resets at end of line.
    always_ff @(posedge pixel_clk or negedge reset_n) begin
        if (!reset_n) begin
            h_count <= 10'd0;
        end else if (h_count == H_TOTAL - 1) begin
            h_count <= 10'd0;
        end else begin
            h_count <= h_count + 10'd1;
        end
    end

    // =========================================================================
    // Vertical counter
    // =========================================================================
    // Counts scanlines. Increments at end of each horizontal line.
    always_ff @(posedge pixel_clk or negedge reset_n) begin
        if (!reset_n) begin
            v_count <= 10'd0;
        end else if (h_count == H_TOTAL - 1) begin
            if (v_count == V_TOTAL - 1) begin
                v_count <= 10'd0;
            end else begin
                v_count <= v_count + 10'd1;
            end
        end
    end

    // =========================================================================
    // Sync signal generation
    // =========================================================================
    // hsync active during sync pulse region (after visible + front porch)
    // Horizontal regions:  [0..639] visible
    //                      [640..655] front porch
    //                      [656..751] sync pulse (active low)
    //                      [752..799] back porch
    always_ff @(posedge pixel_clk or negedge reset_n) begin
        if (!reset_n) begin
            hsync <= ~H_SYNC_ACTIVE;    // Inactive during reset
        end else if (h_count >= (H_VISIBLE + H_FRONT_PORCH) &&
                     h_count <  (H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE)) begin
            hsync <= H_SYNC_ACTIVE;     // Active (low)
        end else begin
            hsync <= ~H_SYNC_ACTIVE;    // Inactive (high)
        end
    end

    // Vertical regions:  [0..479] visible
    //                    [480..489] front porch
    //                    [490..491] sync pulse (active low)
    //                    [492..524] back porch
    always_ff @(posedge pixel_clk or negedge reset_n) begin
        if (!reset_n) begin
            vsync <= ~V_SYNC_ACTIVE;    // Inactive during reset
        end else if (v_count >= (V_VISIBLE + V_FRONT_PORCH) &&
                     v_count <  (V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE)) begin
            vsync <= V_SYNC_ACTIVE;     // Active (low)
        end else begin
            vsync <= ~V_SYNC_ACTIVE;    // Inactive (high)
        end
    end

    // =========================================================================
    // Video active signal and pixel coordinates
    // =========================================================================
    assign video_active = (h_count < H_VISIBLE) && (v_count < V_VISIBLE);
    assign pixel_x      = h_count[9:0];
    assign pixel_y      = v_count[8:0];

endmodule
