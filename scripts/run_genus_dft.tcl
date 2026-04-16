puts "============================================================"
puts "  Genus Synthesis + DFT Script for rca_32bit"
puts "  Technology: 90nm"
puts "============================================================"

set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib/
set_db library slow.lib

puts "\n>>> Reading RTL Design..."
read_hdl ./full_adder.v
read_hdl ./rca_32bit.v

puts "\n>>> Elaborating Design..."
set_db hdl_unconnected_value 0
elaborate rca_32bit
check_design -unresolved

puts "\n>>> Reading SDC Constraints..."
read_sdc ./rca_32bit.sdc

set_max_leakage_power 0.0
set_max_dynamic_power 0.0
set_db dft_scan_style muxed_scan
set_db dft_prefix DFT_

define_dft shift_enable -name scan_en_sig -active high scan_en
define_dft test_clock   -name clk_test    -period 10000 clk

puts "\n>>> Synthesizing..."
set_db syn_generic_effort high
syn_generic
set_db syn_map_effort high
syn_map
set_db syn_opt_effort high
syn_opt

puts "\n>>> Inserting Scan Chains..."
check_dft_rules > ./dft_rules_check.rpt
replace_scan
define_scan_chain -name chain1 -sdi scan_in -sdo scan_out -non_shared_output
connect_scan_chains

puts "\n>>> Post-DFT Optimization..."
syn_opt -incr

puts "\n>>> Generating Post-DFT Reports..."
report timing    > ./post_dft_timing.rpt
report area      > ./post_dft_area.rpt
report power     > ./post_dft_power.rpt
report gates     > ./post_dft_gates.rpt
report dft_setup > ./dft_setup.rpt
report dft_chains > ./scan_chains.rpt
check_dft_rules  > ./post_dft_rules.rpt

puts "\n>>> Writing Files for Modus..."
write_hdl > ./rca_32bit_post_dft.v
write_sdf > ./rca_32bit_post_dft.sdf
write_sdc > ./rca_32bit_post_dft.sdc
write_scandef > ./rca_32bit.scandef
write_dft_atpg -library ./rca_32bit_post_dft.v -directory ./

puts "\n============================================================"
puts "  Genus Complete!"
puts "============================================================"
gui_show
