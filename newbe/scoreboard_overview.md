# Scoreboard Overview

The scoreboard is a key component in the UVM testbench for the APB GPIO verification. It is responsible for verifying the correct behavior of the DUT by comparing expected results with actual results.

## Key Responsibilities:

1.  **Transaction-Level Comparison:** The scoreboard receives transactions from the APB, AUX, and IO agents via TLM analysis FIFOs.
2.  **Register Value Sampling:** It samples the values of the GPIO registers from the register block.
3.  **Reference Model:** It contains a reference model that predicts the expected behavior of the DUT based on the input transactions.
4.  **Outcome Checking:** It compares the predicted behavior with the actual behavior observed from the DUT and reports any discrepancies.
5.  **Coverage Collection:** It collects functional coverage information to measure the verification progress.

## Scoreboard Architecture:

*   **UVM Component:** The scoreboard is a `uvm_scoreboard` component.
*   **TLM FIFOs:**
    *   `apb_fifo`: Receives APB transactions (`apb_xtn`).
    *   `aux_fifo`: Receives AUX transactions (`aux_xtn`).
    *   `io_fifo`: Receives IO transactions (`io_xtn`).
*   **Transaction Handles:**
    *   `apb_h`, `apb_cov_h`: APB transaction handles.
    *   `io_h`, `io_cov_h`: IO transaction handles.
    *   `aux_h`, `aux_cov_h`: AUX transaction handles.
*   **Outcome Flags:** A set of bit flags to track the pass/fail status of different test scenarios.
*   **Covergroups:**
    *   `APB_CG`: Collects coverage on APB bus signals (Address, Reset, Write Data, Write/Read, PENABLE, PSEL, IRQ).
    *   `OUTCOME_CG`: Collects coverage on the test outcomes.
*   **Register Handles:** Local registers to store the values of the DUT's registers.
*   **Reference Model Signals:** Logic signals to model the internal behavior of the DUT.

## Verification Logic:

The `check_phase` of the scoreboard contains the main verification logic. It checks the following scenarios:

*   **GPIO as Output:** Verifies that the value written to the `rgpio_out` register is reflected on the `io_pad`.
*   **GPIO as Output (AUX):** Verifies that the value from the `aux_in` is reflected on the `io_pad`.
*   **GPIO as Input:** Verifies that the value on the `io_pad` is correctly read into the `rgpio_in` register.
*   **GPIO as Input (Interrupt):** Verifies that an interrupt is generated when the input value changes, according to the interrupt configuration registers (`rgpio_inte`, `rgpio_ptrig`, `rgpio_nec`, `rgpio_ctrl`).
*   **GPIO as External Clock:** Verifies that the DUT correctly samples the input data on the edge of the external clock.
*   **GPIO as Bidirectional:** Verifies the functionality of the GPIO pins when configured as both input and output.
*   **Interrupt Clearing:** Verifies that the interrupt can be cleared correctly.

## How it Works:

1.  The `run_phase` continuously gets transactions from the FIFOs.
2.  It samples the covergroups.
3.  It calls `sample_reg` to read the DUT's register values.
4.  The `check_phase` is called at the end of the test to perform the final verification checks based on the collected data and the test configuration.

This scoreboard provides a comprehensive verification of the APB GPIO controller's functionality.
