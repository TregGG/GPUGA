// =============================================================================
// pll_25mhz.v — PLL to generate 25 MHz pixel clock from 50 MHz input
// =============================================================================
// Uses Altera altpll megafunction for Cyclone IV EP4CE22F17C6N.
// Input:  50 MHz (DE0-Nano onboard oscillator)
// Output: 25 MHz (VGA 640x480 @ 60Hz pixel clock)
//
// NOTE: This file uses Verilog (not SystemVerilog) because Quartus
// megafunction wrappers are traditionally Verilog.
// =============================================================================

module pll_25mhz (
    input  wire clk_in,      // 50 MHz input clock
    output wire clk_out,     // 25 MHz pixel clock output
    output wire locked       // PLL lock indicator
);

    wire [4:0] clk_unused;   // unused clock outputs

    altpll #(
        .bandwidth_type          ("AUTO"),
        .clk0_divide_by          (2),        // 50 / 2 = 25 MHz
        .clk0_duty_cycle         (50),
        .clk0_multiply_by        (1),
        .clk0_phase_shift        ("0"),
        .compensate_clock        ("CLK0"),
        .inclk0_input_frequency  (20000),    // 50 MHz = 20,000 ps period
        .intended_device_family  ("Cyclone IV E"),
        .lpm_hint                ("CBX_MODULE_PREFIX=pll_25mhz"),
        .lpm_type                ("altpll"),
        .operation_mode          ("NORMAL"),
        .pll_type                ("AUTO"),
        .port_activeclock        ("PORT_UNUSED"),
        .port_areset             ("PORT_UNUSED"),
        .port_clkbad0            ("PORT_UNUSED"),
        .port_clkbad1            ("PORT_UNUSED"),
        .port_clkloss            ("PORT_UNUSED"),
        .port_clkswitch          ("PORT_UNUSED"),
        .port_configupdate       ("PORT_UNUSED"),
        .port_fbin               ("PORT_UNUSED"),
        .port_inclk0             ("PORT_USED"),
        .port_inclk1             ("PORT_UNUSED"),
        .port_locked             ("PORT_USED"),
        .port_pfdena             ("PORT_UNUSED"),
        .port_phasecounterselect ("PORT_UNUSED"),
        .port_phasedone          ("PORT_UNUSED"),
        .port_phasestep          ("PORT_UNUSED"),
        .port_phaseupdown        ("PORT_UNUSED"),
        .port_pllena             ("PORT_UNUSED"),
        .port_scanaclr           ("PORT_UNUSED"),
        .port_scanclk            ("PORT_UNUSED"),
        .port_scanclkena         ("PORT_UNUSED"),
        .port_scandata           ("PORT_UNUSED"),
        .port_scandataout        ("PORT_UNUSED"),
        .port_scandone           ("PORT_UNUSED"),
        .port_scanread           ("PORT_UNUSED"),
        .port_scanwrite          ("PORT_UNUSED"),
        .port_clk0               ("PORT_USED"),
        .port_clk1               ("PORT_UNUSED"),
        .port_clk2               ("PORT_UNUSED"),
        .port_clk3               ("PORT_UNUSED"),
        .port_clk4               ("PORT_UNUSED"),
        .port_clk5               ("PORT_UNUSED"),
        .self_reset_on_loss_lock ("OFF"),
        .width_clock             (5)
    ) altpll_inst (
        .inclk  ({1'b0, clk_in}),
        .clk    ({clk_unused, clk_out}),
        .locked (locked),
        // Unused ports tied off
        .activeclock       (),
        .areset            (1'b0),
        .clkbad            (),
        .clkena            ({6{1'b1}}),
        .clkloss           (),
        .clkswitch         (1'b0),
        .configupdate      (1'b0),
        .enable0           (),
        .enable1           (),
        .extclk            (),
        .extclkena         ({4{1'b1}}),
        .fbin              (1'b1),
        .fbmimicbidir      (),
        .fbout             (),
        .fref              (),
        .icdrclk           (),
        .pfdena            (1'b1),
        .phasecounterselect({4{1'b1}}),
        .phasedone         (),
        .phasestep         (1'b1),
        .phaseupdown       (1'b1),
        .pllena            (1'b1),
        .scanaclr          (1'b0),
        .scanclk           (1'b0),
        .scanclkena        (1'b0),
        .scandata          (1'b0),
        .scandataout       (),
        .scandone          (),
        .scanread          (1'b0),
        .scanwrite         (1'b0),
        .sclkout0          (),
        .sclkout1          (),
        .vcooverrange      (),
        .vcounderrange     ()
    );

endmodule
