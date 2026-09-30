# =============================================================================
# de0nano_pins.tcl — Pin assignments for DE0-Nano GPU project
# =============================================================================
# Run this in Quartus TCL console:
#   source de0nano_pins.tcl
#
# Or add to .qsf file manually.
# Pin numbers from DE0-Nano User Manual (Board_documentation.pdf)
# =============================================================================

# =============================================================================
# Device settings
# =============================================================================
set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE22F17C6
set_global_assignment -name TOP_LEVEL_ENTITY top_level

# =============================================================================
# Clock — 50 MHz oscillator
# =============================================================================
set_location_assignment PIN_R8 -to CLOCK_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50

# =============================================================================
# Pushbuttons (active low)
# =============================================================================
set_location_assignment PIN_J15 -to KEY[0]
set_location_assignment PIN_E1  -to KEY[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[1]

# =============================================================================
# DIP Switches
# =============================================================================
set_location_assignment PIN_M1  -to SW[0]
set_location_assignment PIN_T8  -to SW[1]
set_location_assignment PIN_B9  -to SW[2]
set_location_assignment PIN_M15 -to SW[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3]

# =============================================================================
# LEDs
# =============================================================================
set_location_assignment PIN_A15 -to LED[0]
set_location_assignment PIN_A13 -to LED[1]
set_location_assignment PIN_B13 -to LED[2]
set_location_assignment PIN_A11 -to LED[3]
set_location_assignment PIN_D1  -to LED[4]
set_location_assignment PIN_F3  -to LED[5]
set_location_assignment PIN_B1  -to LED[6]
set_location_assignment PIN_L3  -to LED[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[7]

# =============================================================================
# GPIO Header 0 — VGA R-2R DAC output
# =============================================================================
# Pin assignments from DE0-Nano User Manual Table 3-5
set_location_assignment PIN_D3  -to GPIO_0[0]
set_location_assignment PIN_C3  -to GPIO_0[1]
set_location_assignment PIN_A2  -to GPIO_0[2]
set_location_assignment PIN_A3  -to GPIO_0[3]
set_location_assignment PIN_B3  -to GPIO_0[4]
set_location_assignment PIN_B4  -to GPIO_0[5]
set_location_assignment PIN_A4  -to GPIO_0[6]
set_location_assignment PIN_B5  -to GPIO_0[7]
set_location_assignment PIN_A5  -to GPIO_0[8]
set_location_assignment PIN_D5  -to GPIO_0[9]
set_location_assignment PIN_B6  -to GPIO_0[10]
set_location_assignment PIN_A6  -to GPIO_0[11]
set_location_assignment PIN_B7  -to GPIO_0[12]
set_location_assignment PIN_D6  -to GPIO_0[13]
set_location_assignment PIN_A7  -to GPIO_0[14]
set_location_assignment PIN_C6  -to GPIO_0[15]
set_location_assignment PIN_C8  -to GPIO_0[16]
set_location_assignment PIN_E6  -to GPIO_0[17]
set_location_assignment PIN_E7  -to GPIO_0[18]
set_location_assignment PIN_D8  -to GPIO_0[19]
set_location_assignment PIN_E8  -to GPIO_0[20]
set_location_assignment PIN_F8  -to GPIO_0[21]
set_location_assignment PIN_F9  -to GPIO_0[22]
set_location_assignment PIN_E9  -to GPIO_0[23]
set_location_assignment PIN_C9  -to GPIO_0[24]
set_location_assignment PIN_D9  -to GPIO_0[25]
set_location_assignment PIN_E11 -to GPIO_0[26]
set_location_assignment PIN_E10 -to GPIO_0[27]
set_location_assignment PIN_C11 -to GPIO_0[28]
set_location_assignment PIN_B11 -to GPIO_0[29]
set_location_assignment PIN_A12 -to GPIO_0[30]
set_location_assignment PIN_D11 -to GPIO_0[31]
set_location_assignment PIN_D12 -to GPIO_0[32]
set_location_assignment PIN_B12 -to GPIO_0[33]

# Set I/O standard for all GPIO_0 pins
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[28]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[29]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[30]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[31]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[32]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[33]

# =============================================================================
# Drive strength for VGA output pins — set to maximum for clean DAC signal
# =============================================================================
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[0]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[1]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[2]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[3]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[4]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[5]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[6]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[7]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[8]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[9]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[10]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[11]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[12]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to GPIO_0[13]
