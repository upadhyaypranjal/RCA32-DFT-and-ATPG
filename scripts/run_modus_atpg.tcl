puts "\n============================================="
puts "Starting Modus Test Run Script for rca_32bit"
puts "=============================================\n"

set WORKDIR ./
set CELL rca_32bit
set RESULTS_DIR $WORKDIR/results
file mkdir $RESULTS_DIR

set NETLIST $WORKDIR/rca_32bit_post_dft.v
set LIBRARY "/home/install/FOUNDRY/digital/90nm/dig/vlog/typical.v"
set TESTMODE FULLSCAN

set ASSIGNFILE ""
set MODEDEF ""
catch {
    set ASSIGNFILE [exec bash -c "find $WORKDIR -type f -name \"*.pinassign\" | head -n 1"]
    set MODEDEF [exec bash -c "find $WORKDIR -type f -name \"*.modedef\" | head -n 1"]
}

puts ">>> Building Test Model"
build_model -cell $CELL -workdir $WORKDIR -designsource $NETLIST -techlib $LIBRARY -designtop $CELL -allowmissingmodules yes 

puts ">>> Building Test Mode $TESTMODE"
if {$MODEDEF ne ""} {
    build_testmode -workdir $WORKDIR -testmode $TESTMODE -modedef $MODEDEF -assignfile $ASSIGNFILE 
} else {
    build_testmode -workdir $WORKDIR -testmode $TESTMODE -assignfile $ASSIGNFILE 
}

puts ">>> Verifying & Reporting Test Structures..."
verify_test_structures -workdir $WORKDIR -testmode $TESTMODE > $RESULTS_DIR/verify_structures.rpt
report_test_structures -workdir $WORKDIR -testmode $TESTMODE > $RESULTS_DIR/test_structures.rpt

puts ">>> Building Test Fault Model..."
build_faultmodel -fullfault yes

puts ">>> Generating ATPG Tests..."
create_scanchain_tests -testmode $TESTMODE -experiment scan
create_logic_tests -testmode $TESTMODE -experiment logic

redirect $RESULTS_DIR/test_coverage_logic.rpt {
    report_statistics -experiment logic
}

puts ">>> Writing Verilog Vectors..."
write_vectors -testmode $TESTMODE -inexperiment logic -language verilog -scanformat serial -outputfilename $RESULTS_DIR/test_results.v

puts "\n============================================="
puts "Modus Run Complete."
puts "=============================================\n"
gui_open


