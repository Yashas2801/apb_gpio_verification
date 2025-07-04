"""
Simulation automation for Mentor's QuestaSim (Questa targets).

This script replicates the functionality of a complex Makefile for the apb_gpio project.
It defines targets for cleaning, compiling (sv_cmp), running various tests,
viewing waveforms, merging coverage reports, and more.

Project Directory Structure (example):
├── apb_agent
├── assertions
├── aux_agent
├── env
├── io_agent
├── rtl
├── sim      <-- This script resides here.
├── test
└── top

Usage:
    python sim.py [target]

For example:
    python sim.py help
    python sim.py run_test
    python sim.py view_wave1
"""

import os
import subprocess
import sys
import argparse

# ========================================
# SECTION: Configuration Variables
# ========================================

SIMULATOR = "Questa"
RTL = "../rtl/*"
work = "work"
SVTB1 = "../top/top.sv"
SVTB2 = "../top/GPIO_pkg.sv"
ASSERTIONS = "../assertions/gpio_assertions.sv"
INC = "+incdir+../top +incdir+../test +incdir+../io_agent +incdir+../env +incdir+../apb_agent +incdir+../aux_agent"
VSIMOPT = ["-vopt", "-voptargs=+acc"]
VSIMCOV = ["-coverage", "-sva"]

# Batch commands for different tests
VSIMBATCH_CMDS = {
    1:  '-c -do "log -r /*; coverage save -onexit mem_cov1; run -all; exit"',
    2:  '-c -do "log -r /*; coverage save -onexit mem_cov2; run -all; exit"',
    3:  '-c -do "log -r /*; coverage save -onexit mem_cov3; run -all; exit"',
    4:  '-c -do "log -r /*; coverage save -onexit mem_cov4; run -all; exit"',
    5:  '-c -do "log -r /*; coverage save -onexit mem_cov5; run -all; exit"',
    6:  '-c -do "log -r /*; coverage save -onexit mem_cov6; run -all; exit"',
    7:  '-c -do "log -r /*; coverage save -onexit mem_cov7; run -all; exit"',
    8:  '-c -do "log -r /*; coverage save -onexit mem_cov8; run -all; exit"',
    9:  '-c -do "log -r /*; coverage save -onexit mem_cov9; run -all; exit"',
    10: '-c -do "log -r /*; coverage save -onexit mem_cov10; run -all; exit"',
    11: '-c -do "log -r /*; coverage save -onexit mem_cov11; run -all; exit"',
    12: '-c -do "log -r /*; coverage save -onexit mem_cov12; run -all; exit"',
    13: '-c -do "log -r /*; coverage save -onexit mem_cov13; run -all; exit"',
    14: '-c -do "log -r /*; coverage save -onexit mem_cov14; run -all; exit"',
    15: '-c -do "log -r /*; coverage save -onexit mem_cov15; run -all; exit"',
}

VERBOSITY = "+UVM_VERBOSITY=UVM_MEDIUM"

TEST_NAMES = {
    1: "gpio_test_base",
    2: "gpio_test_output",
    3: "gpio_test_output_aux",
    4: "gpio_test_input_int1",
    5: "gpio_test_input_int2",
    6: "gpio_test_input_ext1",
    7: "gpio_test_input_ext2",
    8: "gpio_test_bidir",
    9: "gpio_test_input",
    10: "gpio_test_input_ext1_int1",
    11: "gpio_test_input_ext2_int1",
    12: "gpio_test_input_ext1_int2",
    13: "gpio_test_input_ext2_int2",
    14: "gpio_test_input_int_clear",
    15: "gpio_test_bidir_clear",
}

# ========================================
# SECTION: Utility Function
# ========================================

def run_command(cmd, shell=False):
    """
    Runs an external command, stopping the script if the command fails.
    """
    print(f"Running: {cmd}")
    try:
        subprocess.check_call(cmd, shell=shell)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {cmd}")
        sys.exit(e.returncode)

# ========================================
# SECTION: QuestaSim Target Functions
# ========================================

def sv_cmp_Questa():
    """
    Create the simulation library, map it, and compile RTL and testbench files.
    """
    run_command(f"vlib {work}", shell=True)
    run_command(f"vmap work {work}", shell=True)
    cmd = f"vlog -work {work} {RTL} {INC} {SVTB2} {SVTB1} {ASSERTIONS}"
    run_command(cmd, shell=True)

def run_test_template(test_num):
    """
    Generic template for running a single, self-contained test.
    It compiles, simulates, generates coverage, and logs the output.
    """
    test_name = TEST_NAMES[test_num]
    vsim_batch = VSIMBATCH_CMDS[test_num]
    wave_file = f"wave_file{test_num}.wlf"
    log_file = f"test{test_num}.log"
    mem_cov = f"mem_cov{test_num}"
    full_log_file = f"test{test_num}_full.log"

    # This single command string replicates the Makefile's logic for each test,
    # including the redirection of output to a log file.
    cmd = (
        f"( "
        f"vlib {work} && "
        f"vmap work {work} && "
        f"vlog -work {work} {RTL} {INC} {SVTB2} {SVTB1} {ASSERTIONS} && "
        f"vsim -cvgperinstance {' '.join(VSIMOPT)} {' '.join(VSIMCOV)} {vsim_batch} {VERBOSITY} "
        f"-wlf {wave_file} -l {log_file} -sv_seed random work.top +UVM_TESTNAME={test_name} && "
        f"vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html {mem_cov} "
        f") 2>&1 | tee {full_log_file}"
    )
    run_command(cmd, shell=True)

def run_test_Questa(): run_test_template(1)
def run_test1_Questa(): run_test_template(2)
def run_test2_Questa(): run_test_template(3)
def run_test3_Questa(): run_test_template(4)
def run_test4_Questa(): run_test_template(5)
def run_test5_Questa(): run_test_template(6)
def run_test6_Questa(): run_test_template(7)
def run_test7_Questa(): run_test_template(8)
def run_test8_Questa(): run_test_template(9)
def run_test9_Questa(): run_test_template(10)
def run_test10_Questa(): run_test_template(11)
def run_test11_Questa(): run_test_template(12)
def run_test12_Questa(): run_test_template(13)
def run_test13_Questa(): run_test_template(14)
def run_test14_Questa(): run_test_template(15)

def view_wave_Questa(test_num):
    run_command(f"vsim -view wave_file{test_num}.wlf", shell=True)

def report_Questa():
    """
    Merge coverage reports from all tests and generate an HTML report.
    """
    mem_cov_files = " ".join([f"mem_cov{i}" for i in range(1, 16)])
    run_command(f"vcover merge mem_cov {mem_cov_files}", shell=True)
    run_command("vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov", shell=True)

def regress_Questa():
    """
    Clean, compile, and run all test cases sequentially, then merge coverage reports.
    """
    clean_Questa()
    for i in range(1, 16):
        run_test_template(i)
    report_Questa()

def cov_Questa():
    """
    Open the merged coverage report in Firefox.
    """
    run_command("firefox covhtmlreport/index.html &", shell=True)

def clean_Questa():
    """
    Clean generated simulation files.
    """
    run_command("rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini " + work, shell=True)
    run_command("clear", shell=True)

# ========================================
# SECTION: Custom Help Function
# ========================================

def print_custom_help():
    help_text = """
==================================================================================
 Makefile Help for Questa Simulation
==================================================================================
This Makefile automates compilation, simulation, and coverage analysis of a
SystemVerilog/UVM testbench using Mentor Graphics Questa simulator for a GPIO design.

Usage: python sim.py <target>

Available Targets:
-----------------
General Targets:
  help          : Display this help message.
  clean         : Remove all generated files (logs, coverage, waveforms, work library).
  sv_cmp        : Create work library and compile RTL and testbench source files.
  regress       : Run all test cases (clean, compile, simulate, merge coverage).
  report        : Merge coverage reports from all tests and generate HTML report.
  cov           : Open the merged HTML coverage report in Firefox.

Test Execution Targets (clean, compile, run with coverage):
  run_test      : Run gpio_test_base test.
  run_test1     : Run gpio_test_output test.
  run_test2     : Run gpio_test_output_aux test.
  run_test3     : Run gpio_test_input_int1 test.
  run_test4     : Run gpio_test_input_int2 test.
  run_test5     : Run gpio_test_input_ext1 test.
  run_test6     : Run gpio_test_input_ext2 test.
  run_test7     : Run gpio_test_bidir test.
  run_test8     : Run gpio_test_input test.
  run_test9     : Run gpio_test_input_ext1_int1 test.
  run_test10    : Run gpio_test_input_ext2_int1 test.
  run_test11    : Run gpio_test_input_ext1_int2 test.
  run_test12    : Run gpio_test_input_ext2_int2 test.
  run_test13    : Run gpio_test_input_int_clear test.
  run_test14    : Run gpio_test_bidir_clear test.

Waveform Viewing Targets:
  view_wave1    : View waveform for gpio_test_base.
  view_wave2    : View waveform for gpio_test_output.
  view_wave3    : View waveform for gpio_test_output_aux.
  view_wave4    : View waveform for gpio_test_input_int1.
  view_wave5    : View waveform for gpio_test_input_int2.
  view_wave6    : View waveform for gpio_test_input_ext1.
  view_wave7    : View waveform for gpio_test_input_ext2.
  view_wave8    : View waveform for gpio_test_bidir.
  view_wave9    : View waveform for gpio_test_input.
  view_wave10   : View waveform for gpio_test_input_ext1_int1.
  view_wave11   : View waveform for gpio_test_input_ext2_int1.
  view_wave12   : View waveform for gpio_test_input_ext1_int2.
  view_wave13   : View waveform for gpio_test_input_ext2_int2.
  view_wave14   : View waveform for gpio_test_input_int_clear.
  view_wave15   : View waveform for gpio_test_bidir_clear.

==================================================================================
"""
    print(help_text)

# ========================================
# SECTION: Command-Line Interface
# ========================================

def main():
    # Define all possible targets
    targets = {
        "help": print_custom_help,
        "clean": clean_Questa,
        "sv_cmp": sv_cmp_Questa,
        "regress": regress_Questa,
        "report": report_Questa,
        "cov": cov_Questa,
    }
    # Add run_test targets
    for i in range(1, 16):
        test_name = f"run_test{i-1}" if i > 1 else "run_test"
        targets[test_name] = lambda i=i: run_test_template(i)

    # Add view_wave targets
    for i in range(1, 16):
        targets[f"view_wave{i}"] = lambda i=i: view_wave_Questa(i)

    parser = argparse.ArgumentParser(
        description="Simulation automation script for QuestaSim.",
        add_help=False
    )
    parser.add_argument("target",
                        nargs="?",
                        choices=list(targets.keys()),
                        default="help",
                        help="The target to execute.")
    args = parser.parse_args()

    # Execute the function associated with the chosen target
    func = targets.get(args.target)
    if func:
        func()
    else:
        print_custom_help()

if __name__ == "__main__":
    main()