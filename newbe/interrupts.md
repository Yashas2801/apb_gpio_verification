# GPIO Interrupts: A Deep Dive

This document provides a comprehensive explanation of the interrupt functionality within the APB GPIO controller, covering both the design and verification aspects.

## Design Perspective

### What is a GPIO Interrupt?

A GPIO interrupt is a signal generated by the GPIO controller to notify the main processor or system when a specific event occurs on one of its input pins. This is a more efficient way to handle external events than constantly polling the input registers.

### How Interrupts Work in this Design

An interrupt is generated when a change is detected on a GPIO pin that is configured as an input and is enabled for interrupts. The interrupt generation logic is highly configurable.

### Key Registers Involved

The following registers are crucial for controlling and managing interrupts:

*   **`RGPIO_OE` (Output Enable):** To generate an interrupt, a pin must be configured as an input by setting the corresponding bit in this register to `0`.
*   **`RGPIO_INTE` (Interrupt Enable):** This register enables or disables interrupts on a per-pin basis. A `1` in a bit position enables interrupts for the corresponding pin.
*   **`RGPIO_PTRIG` (Polarity Trigger):** This register defines the edge that will trigger the interrupt. A `1` sets a positive-edge (rising edge) trigger, and a `0` sets a negative-edge (falling edge) trigger.
*   **`RGPIO_INTS` (Interrupt Status):** This is a read/write register. When an interrupt condition is met, the corresponding bit in this register is set to `1`. The system can read this register to determine the source of the interrupt. Writing a `1` to a bit in this register clears the pending interrupt for that pin.
*   **`RGPIO_CTRL` (Control Register):** This 2-bit register provides global control over the interrupt mechanism:
    *   **Bit 0 (`INTE`):** Global Interrupt Enable. When this bit is `1`, the `gpio_inta_o` output signal can be asserted if any interrupt is pending. If this bit is `0`, all interrupts are masked.
    *   **Bit 1 (`INTS`):** Global Interrupt Status. This bit reflects the overall interrupt status. It becomes `1` if any bit in `RGPIO_INTS` is `1` and the global enable is active.

### Interrupt Generation Flow

1.  **Configuration:** The system configures a GPIO pin for interrupt generation by:
    a.  Setting the pin as an input (`RGPIO_OE`).
    b.  Enabling the interrupt for the pin (`RGPIO_INTE`).
    c.  Selecting the trigger polarity (`RGPIO_PTRIG`).
    d.  Enabling interrupts globally (`RGPIO_CTRL[0]`).

2.  **Event Detection:** The hardware continuously monitors the input pin for the specified edge (positive or negative).

3.  **Status Update:** When the configured edge is detected, the corresponding bit in the `RGPIO_INTS` register is set to `1`.

4.  **Interrupt Assertion:** The `gpio_inta_o` output signal is asserted (goes high) if at least one bit in `RGPIO_INTS` is `1` and the global interrupt enable bit in `RGPIO_CTRL` is also `1`.

### Clearing an Interrupt

Once an interrupt has been serviced, it needs to be cleared to allow for the detection of new interrupts. This can be done in a few ways:

*   **Directly:** By writing a `1` to the specific bit in the `RGPIO_INTS` register that corresponds to the interrupt that occurred.
*   **Globally:** By clearing the global interrupt enable bit in the `RGPIO_CTRL` register.

## Verification Perspective

The verification of the interrupt functionality is a critical part of the overall test plan. The scoreboard and a series of targeted tests are used to ensure that interrupts are generated and cleared correctly under all specified conditions.

### Scoreboard's Role

The scoreboard plays a central role in verifying interrupts:

1.  **Monitoring:** It receives APB transactions, including the `IRQ` (Interrupt ReQuest) status, through its `apb_fifo`.
2.  **Reference Model:** The scoreboard contains a reference model (`rgpio_ints_e`) that independently calculates the expected state of the `RGPIO_INTS` register based on the stimulus applied to the DUT.
3.  **Comparison:** In the `check_phase`, the scoreboard compares the value of its reference model (`rgpio_ints_e`) with the actual value of the `RGPIO_INTS` register read from the DUT. It also checks if the `apb_h.IRQ` signal was asserted at the correct times.

### Verification Strategy

The verification strategy for interrupts is to create specific scenarios that target different aspects of the interrupt logic. The test plan includes a variety of tests to cover these scenarios:

*   **Basic Interrupts:** `gpio_test_input_int1` and `gpio_test_input_int2` test for basic positive and negative edge-triggered interrupts.
*   **Interrupts with External Clock:** Tests like `gpio_test_input_ext1_int1` and `gpio_test_input_ext2_int2` verify that interrupts are correctly generated when the input is sampled by an external clock source, considering both positive and negative edges for both the data and the clock.
*   **Interrupt Clearing:** The `gpio_test_input_int_clear` and `gpio_test_bidir_clear` tests are specifically designed to verify that interrupts can be cleared correctly after they have been generated.

By combining these targeted tests with the scoreboard's checking mechanism, the verification environment ensures that the GPIO controller's interrupt functionality is robust and reliable.