# Prolog Theorem Prover

[![Prolog Tests](https://github.com/gregb122/Theorem-prover/actions/workflows/ci.yml/badge.svg)](https://github.com/gregb122/Theorem-prover/actions/workflows/ci.yml)

This project is a theorem prover implemented in Prolog.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have SWI-Prolog installed on your machine.

### Installing

Clone the repository to your local machine.

```bash
git clone git@github.com:gregb122/Theorem-prover.git
```

Navigate to the project directory.

```bash
cd Theorem-prover
```

Run the Prolog interpreter.

```bash
swipl
```

Load the theorem prover.

```prolog
[theorem_prover].
```

## Running the tests

The tests for this project are located in the `tests` directory. To run all tests, use the `test_all` predicate.

```bash
swipl -g 'test_all,halt' checker.pl
```

## Test Results

For each executed test, the checker displays the execution time (if the test completed) and the execution status. Possible values are:

- `ok` - the program passed the test
- `wrong answer` - incorrect answer
- `tle` - time limit exceeded
- `invalid test` - invalid test format
- `invalid answer` - invalid solution format

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
