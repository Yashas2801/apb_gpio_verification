SIMULATOR = Questa

RTL = ../rtl/*
work = work # library name
SVTB1 = ../top/top.sv
INC = +incdir+../top +incdir+../test +incdir+../io_agent +incdir+../env +incdir+../apb_agent +incdir+../aux_agent
SVTB2 = ../top/GPIO_pkg.sv
VSIMOPT = -vopt -voptargs=+acc
VSIMCOV = -coverage -sva
VSIMBATCH1 = -c -do "log -r /*; coverage save -onexit mem_cov1; run -all; exit"
VSIMBATCH2 = -c -do "log -r /*; coverage save -onexit mem_cov2; run -all; exit"
VSIMBATCH3 = -c -do "log -r /*; coverage save -onexit mem_cov3; run -all; exit"
VSIMBATCH4 = -c -do "log -r /*; coverage save -onexit mem_cov4; run -all; exit"
VSIMBATCH5 = -c -do "log -r /*; coverage save -onexit mem_cov5; run -all; exit"
VSIMBATCH6 = -c -do "log -r /*; coverage save -onexit mem_cov6; run -all; exit"
VSIMBATCH7 = -c -do "log -r /*; coverage save -onexit mem_cov7; run -all; exit"
VSIMBATCH8 = -c -do "log -r /*; coverage save -onexit mem_cov8; run -all; exit"
VSIMBATCH9 = -c -do "log -r /*; coverage save -onexit mem_cov9; run -all; exit"
VSIMBATCH10 = -c -do "log -r /*; coverage save -onexit mem_cov10; run -all; exit"
VSIMBATCH11 = -c -do "log -r /*; coverage save -onexit mem_cov11; run -all; exit"
VSIMBATCH12 = -c -do "log -r /*; coverage save -onexit mem_cov12; run -all; exit"
VSIMBATCH13 = -c -do "log -r /*; coverage save -onexit mem_cov13; run -all; exit"
VSIMBATCH14 = -c -do "log -r /*; coverage save -onexit mem_cov14; run -all; exit"
VSIMBATCH15 = -c -do "log -r /*; coverage save -onexit mem_cov15; run -all; exit"

VERBOSITY = +UVM_VERBOSITY=UVM_MEDIUM

# Help target
help:
	@echo "=================================================================================="
	@echo " Makefile Help for Questa Simulation"
	@echo "=================================================================================="
	@echo "This Makefile automates compilation, simulation, and coverage analysis of a"
	@echo "SystemVerilog/UVM testbench using Mentor Graphics Questa simulator for a GPIO design."
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available Targets:"
	@echo "-----------------"
	@echo "General Targets:"
	@echo "  help          : Display this help message."
	@echo "  clean         : Remove all generated files (logs, coverage, waveforms, work library)."
	@echo "  sv_cmp        : Create work library and compile RTL and testbench source files."
	@echo "  regress       : Run all test cases (clean, compile, simulate, merge coverage)."
	@echo "  report        : Merge coverage reports from all tests and generate HTML report."
	@echo "  cov           : Open the merged HTML coverage report in Firefox."
	@echo ""
	@echo "Test Execution Targets (clean, compile, run with coverage):"
	@echo "  run_test      : Run gpio_test_base test."
	@echo "  run_test1     : Run gpio_test_output test."
	@echo "  run_test2     : Run gpio_test_output_aux test."
	@echo "  run_test3     : Run gpio_test_input_int1 test."
	@echo "  run_test4     : Run gpio_test_input_int2 test."
	@echo "  run_test5     : Run gpio_test_input_ext1 test."
	@echo "  run_test6     : Run gpio_test_input_ext2 test."
	@echo "  run_test7     : Run gpio_test_bidir test."
	@echo "  run_test8     : Run gpio_test_input test."
	@echo "  run_test9     : Run gpio_test_input_ext1_int1 test."
	@echo "  run_test10    : Run gpio_test_input_ext2_int1 test."
	@echo "  run_test11    : Run gpio_test_input_ext1_int2 test."
	@echo "  run_test12    : Run gpio_test_input_ext2_int2 test."
	@echo "  run_test13    : Run gpio_test_input_int_clear test."
	@echo "  run_test14    : Run gpio_test_bidir_clear test."
	@echo ""
	@echo "Waveform Viewing Targets:"
	@echo "  view_wave1    : View waveform for gpio_test_base."
	@echo "  view_wave2    : View waveform for gpio_test_output."
	@echo "  view_wave3    : View waveform for gpio_test_output_aux."
	@echo "  view_wave4    : View waveform for gpio_test_input_int1."
	@echo "  view_wave5    : View waveform for gpio_test_input_int2."
	@echo "  view_wave6    : View waveform for gpio_test_input_ext1."
	@echo "  view_wave7    : View waveform for gpio_test_input_ext2."
	@echo "  view_wave8    : View waveform for gpio_test_bidir."
	@echo "  view_wave9    : View waveform for gpio_test_input."
	@echo "  view_wave10   : View waveform for gpio_test_input_ext1_int1."
	@echo "  view_wave11   : View waveform for gpio_test_input_ext2_int1."
	@echo "  view_wave12   : View waveform for gpio_test_input_ext1_int2."
	@echo "  view_wave13   : View waveform for gpio_test_input_ext2_int2."
	@echo "  view_wave14   : View waveform for gpio_test_input_int_clear."
	@echo "  view_wave15   : View waveform for gpio_test_bidir_clear."
	@echo ""
	@echo "=================================================================================="

# Generic targets
clean: clean_$(SIMULATOR)
sv_cmp: sv_cmp_$(SIMULATOR)
run_test: run_test_$(SIMULATOR)
run_test1: run_test1_$(SIMULATOR)
run_test2: run_test2_$(SIMULATOR)
run_test3: run_test3_$(SIMULATOR)
run_test4: run_test4_$(SIMULATOR)
run_test5: run_test5_$(SIMULATOR)
run_test6: run_test6_$(SIMULATOR)
run_test7: run_test7_$(SIMULATOR)
run_test8: run_test8_$(SIMULATOR)
run_test9: run_test9_$(SIMULATOR)
run_test10: run_test10_$(SIMULATOR)
run_test11: run_test11_$(SIMULATOR)
run_test12: run_test12_$(SIMULATOR)
run_test13: run_test13_$(SIMULATOR)
run_test14: run_test14_$(SIMULATOR)
view_wave1: view_wave1_$(SIMULATOR)
view_wave2: view_wave2_$(SIMULATOR)
view_wave3: view_wave3_$(SIMULATOR)
view_wave4: view_wave4_$(SIMULATOR)
view_wave5: view_wave5_$(SIMULATOR)
view_wave6: view_wave6_$(SIMULATOR)
view_wave7: view_wave7_$(SIMULATOR)
view_wave8: view_wave8_$(SIMULATOR)
view_wave9: view_wave9_$(SIMULATOR)
view_wave10: view_wave10_$(SIMULATOR)
view_wave11: view_wave11_$(SIMULATOR)
view_wave12: view_wave12_$(SIMULATOR)
view_wave13: view_wave13_$(SIMULATOR)
view_wave14: view_wave14_$(SIMULATOR)
view_wave15: view_wave15_$(SIMULATOR)
regress: regress_$(SIMULATOR)
report: report_$(SIMULATOR)
cov: cov_$(SIMULATOR)

# Questa-specific targets
sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) ../assertions/gpio_assertions.sv

run_test_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1) $(VERBOSITY) -wlf wave_file1.wlf -l test1.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_base
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test1_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2) $(VERBOSITY) -wlf wave_file2.wlf -l test2.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_output
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test2_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3) $(VERBOSITY) -wlf wave_file3.wlf -l test3.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_output_aux
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

run_test3_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4) $(VERBOSITY) -wlf wave_file4.wlf -l test4.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_int1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

run_test4_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5) $(VERBOSITY) -wlf wave_file5.wlf -l test5.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_int2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5

run_test5_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6) $(VERBOSITY) -wlf wave_file6.wlf -l test6.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_ext1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6

run_test6_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7) $(VERBOSITY) -wlf wave_file7.wlf -l test7.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_ext2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov7

run_test7_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8) $(VERBOSITY) -wlf wave_file8.wlf -l test8.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_bidir
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov8

run_test8_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9) $(VERBOSITY) -wlf wave_file9.wlf -l test9.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov9

run_test9_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH10) $(VERBOSITY) -wlf wave_file10.wlf -l test10.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_ext1_int1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov10

run_test10_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH11) $(VERBOSITY) -wlf wave_file11.wlf -l test11.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_ext2_int1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov11

run_test11_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH12) $(VERBOSITY) -wlf wave_file12.wlf -l test12.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_ext1_int2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov12

run_test12_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH13) $(VERBOSITY) -wlf wave_file13.wlf -l test13.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_ext2_int2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov13

run_test13_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH14) $(VERBOSITY) -wlf wave_file14.wlf -l test14.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_input_int_clear
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov14

run_test14_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH15) $(VERBOSITY) -wlf wave_file15.wlf -l test15.log -sv_seed random work.top +UVM_TESTNAME=gpio_test_bidir_clear
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov15

view_wave1_Questa:
	vsim -view wave_file1.wlf

view_wave2_Questa:
	vsim -view wave_file2.wlf

view_wave3_Questa:
	vsim -view wave_file3.wlf

view_wave4_Questa:
	vsim -view wave_file4.wlf

view_wave5_Questa:
	vsim -view wave_file5.wlf

view_wave6_Questa:
	vsim -view wave_file6.wlf

view_wave7_Questa:
	vsim -view wave_file7.wlf

view_wave8_Questa:
	vsim -view wave_file8.wlf

view_wave9_Questa:
	vsim -view wave_file9.wlf

view_wave10_Questa:
	vsim -view wave_file10.wlf

view_wave11_Questa:
	vsim -view wave_file11.wlf

view_wave12_Questa:
	vsim -view wave_file12.wlf

view_wave13_Questa:
	vsim -view wave_file13.wlf

view_wave14_Questa:
	vsim -view wave_file14.wlf

view_wave15_Questa:
	vsim -view wave_file15.wlf

report_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9 mem_cov10 mem_cov11 mem_cov12 mem_cov13 mem_cov14 mem_cov15
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress_Questa: clean_Questa run_test_Questa run_test1_Questa run_test2_Questa run_test3_Questa run_test4_Questa run_test5_Questa run_test6_Questa run_test7_Questa run_test8_Questa run_test9_Questa run_test10_Questa run_test11_Questa run_test12_Questa run_test13_Questa run_test14_Questa report_Questa

cov_Questa:
	firefox covhtmlreport/index.html &

clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear
