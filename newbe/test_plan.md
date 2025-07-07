| Test Name | Purpose |
|---|---|
| `gpio_test_output` | Verifies that the GPIO pins can be configured as outputs and drive specific values. This is the most basic output functionality test. |
| `gpio_test_output_aux` | Verifies that the GPIO pins can be configured as outputs and driven using the auxiliary registers. |
| `gpio_test_input_int1` | Tests the interrupt generation functionality. It configures GPIOs as inputs and checks if a positive edge trigger correctly generates an interrupt. |
| `gpio_test_input_int2` | Similar to the `int1` test, but this one verifies interrupt generation on a negative edge trigger. |
| `gpio_test_input_ext1` | Verifies the GPIO input functionality when synchronized with the positive edge of an external clock. |
| `gpio_test_input_ext2` | Similar to the `ext1` test, but this one verifies input functionality synchronized with the negative edge of an external clock. |
| `gpio_test_bidir` | Checks the bidirectional capability of the GPIO pins. It configures some pins as inputs and others as outputs and verifies data transfer in both directions. |
| `gpio_test_input` | Tests the basic input functionality of the GPIOs, synchronized with the main system clock. |
| `gpio_test_input_ext1_int1` | A combined scenario that tests interrupt generation (positive edge) on an input that is synchronized with an external clock (positive edge). |
| `gpio_test_input_ext2_int1` | A combined scenario that tests interrupt generation (positive edge) on an input that is synchronized with an external clock (negative edge). |
| `gpio_test_input_ext1_int2` | A combined scenario that tests interrupt generation (negative edge) on an input that is synchronized with an external clock (positive edge). |
| `gpio_test_input_ext2_int2` | A combined scenario that tests interrupt generation (negative edge) on an input that is synchronized with an external clock (negative edge). |
| `gpio_test_input_int_clear` | Verifies that after an interrupt is generated, its status can be correctly cleared. |
| `gpio_test_bidir_clear` | Verifies that interrupts generated during bidirectional operation can be correctly cleared. |