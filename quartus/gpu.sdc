# =============================================================================
# gpu.sdc — Timing constraints for DE0-Nano GPU
# =============================================================================

# 50 MHz input clock
create_clock -name CLOCK_50 -period 20.000 [get_ports {CLOCK_50}]

# PLL output clock (25 MHz) — Quartus will auto-derive from PLL, but
# we declare it explicitly for clarity
derive_pll_clocks
derive_clock_uncertainty

# Constrain GPIO outputs — these are slow VGA signals, relax timing
set_false_path -to [get_ports {GPIO_0[*]}]
set_false_path -to [get_ports {LED[*]}]
set_false_path -from [get_ports {KEY[*]}]
set_false_path -from [get_ports {SW[*]}]
