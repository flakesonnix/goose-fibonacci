# Fibonacci

Goose implementation of the Fibonacci sequence using recursion.

## Build & Run

```bash
goose build fib.goose && ./fib
```

Or directly in the compiler (JIT):

```bash
goose fib.goose
```

## Expected Output

```
fib(0)  = 0
fib(1)  = 1
fib(10) = 55
fib(20) = 6765
```

## Features

- `recursive fn` for recursive Fibonacci calculation
- Base cases `n <= 1` return `n` directly
- Recursive case: `fib(n - 1) + fib(n - 2)`
- No heap, no allocation — everything on the stack
