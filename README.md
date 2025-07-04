# Verification of APB GPIO (UVM)

This project demonstrates the verification of a GPIO (General-Purpose Input/Output) module with an APB (Advanced Peripheral Bus) interface using the SystemVerilog and UVM methodology. The verification environment is designed to test the functionality of the GPIO, including input, output, bidirectional, and interrupt capabilities.

## Features

- **UVM Testbench**: A comprehensive UVM environment to verify the APB GPIO DUT.
- **Functional Coverage**: Includes functional coverage to ensure that various GPIO modes and APB transactions are covered.
- **Simulation**: Configured to run on QuestaSim, with detailed logs and waveform analysis capabilities.
- **Reusability**: The verification components (agents for APB, IO, and AUX) are designed for reuse.

## APB Protocol

The DUT uses the AMBA APB protocol for communication. The key signals in the APB interface are:
- `PCLK`: The clock signal for the bus.
- `PRESETn`: The active-low reset signal.
- `PADDR`: The address bus that selects a register within the GPIO.
- `PSEL`: The select signal that indicates a transaction is targeting the GPIO.
- `PENABLE`: The enable signal that indicates the second and subsequent cycles of an APB transfer.
- `PWRITE`: Indicates a write (`1`) or read (`0`) transaction.
- `PWDATA`: The data written to the GPIO during a write operation.
- `PRDATA`: The data read from the GPIO during a read operation.
- `PREADY`: The ready signal from the slave, indicating the completion of a transfer.

## Directory Structure

<details>
  <summary>Click to expand</summary>

```
├── apb_agent
│   ├── apb_agent_config.sv
│   ├── apb_agent.sv
│   ├── apb_driver.sv
│   ├── apb_monitor.sv
│   ├── apb_sequence.sv
│   ├── apb_sequencer.sv
│   └── apb_xtn.sv
├── assertions
│   ├── bind_assertions.sv
│   └── gpio_assertions.sv
├── aux_agent
│   ├── aux_agent_config.sv
│   ├── aux_agent.sv
│   ├── aux_driver.sv
│   ├── aux_monitor.sv
│   ├── aux_sequence.sv
│   ├── aux_sequencer.sv
│   └── aux_xtn.sv
├── env
│   ├── env_config.sv
│   ├── env.sv
│   ├── gpio_reg_block.sv
│   ├── ral.sv
│   ├── scoreboard.sv
│   ├── virtual_sequence.sv
│   └── virtual_sequencer.sv
├── io_agent
│   ├── io_agent_config.sv
│   ├── io_agent.sv
│   ├── io_driver.sv
│   ├── io_monitor.sv
│   ├── io_sequence.sv
│   ├── io_sequencer.sv
│   └── io_xtn.sv
├── rtl
│   └── ...
├── sim
│   ├── Makefile
│   └── sim.py
├── test
│   └── test.sv
└── top
    ├── gpio_defines.sv
    ├── GPIO_pkg.sv
    └── top.sv
```
</details>

## Simulation and Verification

### Running Tests

#### Tip - Run this command to see available Makefile options:

```sh
cd sim
make help
```

#### Running tests:

- `make run_test` - Runs `gpio_test_base`.
- `make run_test1` - Runs `gpio_test_output`.
- `make run_test2` - Runs `gpio_test_output_aux`.
- `make run_test3` - Runs `gpio_test_input_int1`.
- `make run_test4` - Runs `gpio_test_input_int2`.
- `make run_test5` - Runs `gpio_test_input_ext1`.
- `make run_test6` - Runs `gpio_test_input_ext2`.
- `make run_test7` - Runs `gpio_test_bidir`.
- `make run_test8` - Runs `gpio_test_input`.
- `make run_test9` - Runs `gpio_test_input_ext1_int1`.
- `make run_test10` - Runs `gpio_test_input_ext2_int1`.
- `make run_test11` - Runs `gpio_test_input_ext1_int2`.
- `make run_test12` - Runs `gpio_test_input_ext2_int2`.
- `make run_test13` - Runs `gpio_test_input_int_clear`.
- `make run_test14` - Runs `gpio_test_bidir_clear`.

#### Viewing Waveforms

To view the waveform of a specific test, run:

```sh
make view_waveX
```

where `X` corresponds to the test number. For example, to view the waveform of `gpio_test_output`, run:

```sh
make view_wave2
```

#### Running Regression and Coverage Reports

- `make regress` - Runs all tests and generates a combined report.
- `make cov` - Opens the merged coverage report in HTML format.
- `make report` - Merges coverage reports for all test cases and converts them to an HTML format.

### Running the Simulation Using the Python Script

<details>
  <summary>Find out how !!</summary>

You can automate compilation, running tests, and generating coverage reports using the **sim.py** script:

- **Compile the RTL and UVM Testbench**:

```sh
python sim.py sv_cmp
```

- **Run a specific test** (e.g., `gpio_test_base`):

```sh
python sim.py run_test
```

- **Run all tests sequentially and merge coverage**:

```sh
python sim.py regress
```

- **View a waveform** after running a test (e.g., for `gpio_test_output`):

```sh
python sim.py view_wave2
```

- **Generate a coverage report**:

```sh
python sim.py report
```

For additional commands:

```sh
python sim.py help
```

</details>

## Scoreboard Overview

The **GPIO scoreboard** is responsible for checking the correctness of the GPIO operations. It compares the expected output with the actual output on the IO pads and verifies interrupt generation.

### Key Features:

- **End-to-End Checking**: Verifies data integrity from APB write to IO pad output and from IO pad input to APB read.
- **Functional Coverage Groups**:
  - `APB_CG`: Covers APB protocol signals like `PADDR`, `PWRITE`, `PSEL`, `PENABLE`, and `IRQ`.
  - `OUTCOME_CG`: Tracks the pass/fail status for each test case.

## Verified GPIO Details

The verified DUT is a 32-bit GPIO module with an APB interface. It provides configurable I/O pins that can be used for general-purpose digital signaling.

### Key Registers:

- **RGPIO_IN**: (Read-Only) Reads the current value from the input pins.
- **RGPIO_OUT**: (Read/Write) Sets the output value for the pins configured as outputs.
- **RGPIO_OE**: (Read/Write) Output Enable register. A `1` configures the corresponding pin as an output, and a `0` configures it as an input.
- **RGPIO_INTE**: (Read/Write) Interrupt Enable register. Enables or disables interrupt generation for each pin.
- **RGPIO_PTRIG**: (Read/Write) Interrupt Polarity Trigger register. Configures interrupts to be triggered on a positive (`1`) or negative (`0`) edge.
- **RGPIO_AUX**: (Read/Write) Auxiliary register to select between `RGPIO_OUT` and an auxiliary input for driving the output pads.
- **RGPIO_CTRL**: (Read/Write) Main control register for the GPIO, including a master interrupt enable.
- **RGPIO_INTS**: (Read/Write) Interrupt Status register. Each bit corresponds to a pin's interrupt status.
- **RGPIO_ECLK**: (Read/Write) Enables an external clock for sampling input data on a per-pin basis.
- **RGPIO_NEC**: (Read/Write) Negative Edge Clock select. Determines if the external clock samples on the positive or negative edge.

---

This project aims to ensure the APB GPIO design is thoroughly verified and functions reliably across different scenarios using UVM.
