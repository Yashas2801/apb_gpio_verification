# GPIO Registers

This document provides a detailed description of the registers used in the APB GPIO controller.

| Register | Address | Description |
|---|---|---|
| `RGPIO_IN` | `0x00` | **GPIO Input Register (Read-Only)**<br>Reflects the current state of the GPIO pins configured as inputs. |
| `RGPIO_OUT` | `0x04` | **GPIO Output Register (Read/Write)**<br>Controls the logic level of the GPIO pins configured as outputs. |
| `RGPIO_OE` | `0x08` | **GPIO Output Enable Register (Read/Write)**<br>Configures the direction of each GPIO pin. A '1' sets the pin as an output, and a '0' sets it as an input. |
| `RGPIO_INTE` | `0x0C` | **GPIO Interrupt Enable Register (Read/Write)**<br>Enables or disables interrupt generation for each individual GPIO pin. |
| `RGPIO_PTRIG`| `0x10` | **GPIO Interrupt Polarity Trigger Register (Read/Write)**<br>Configures the interrupt trigger type for each pin. A '1' sets a positive-edge trigger, and a '0' sets a negative-edge trigger. |
| `RGPIO_AUX` | `0x14` | **GPIO Auxiliary Function Register (Read/Write)**<br>Selects the source for the output pins. A '1' selects the auxiliary input, and a '0' selects the `RGPIO_OUT` register. |
| `RGPIO_CTRL` | `0x18` | **GPIO Control Register (Read/Write)**<br>Contains global control bits for interrupts.<ul><li>Bit 0: Global Interrupt Enable (`INTE`)</li><li>Bit 1: Global Interrupt Status (`INTS`)</li></ul> |
| `RGPIO_INTS` | `0x1C` | **GPIO Interrupt Status Register (Read/Write)**<br>Indicates which GPIO pins have a pending interrupt. A '1' means an interrupt has occurred. This register can be written to clear pending interrupts. |
| `RGPIO_ECLK` | `0x20` | **GPIO External Clock Register (Read/Write)**<br>Selects the clock source for sampling input data for each pin. A '1' selects the external clock, and a '0' selects the system clock. |
| `RGPIO_NEC` | `0x24` | **GPIO Negative Edge Clock Register (Read/Write)**<br>Configures the edge sensitivity for the external clock. A '1' selects the negative edge, and a '0' selects the positive edge. |
