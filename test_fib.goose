// Unit test: Fibonacci (recursive)
// Checks known Fibonacci values.

recursive fn fib(n: i64) -> i64 {
    if n <= 1 { return n; }
    return fib(n - 1) + fib(n - 2);
}

fn main() {
    assert(fib(0) == 0);
    assert(fib(1) == 1);
    assert(fib(2) == 1);
    assert(fib(3) == 2);
    assert(fib(4) == 3);
    assert(fib(5) == 5);
    assert(fib(10) == 55);
    assert(fib(20) == 6765);
    print("fib unit tests passed");
}
