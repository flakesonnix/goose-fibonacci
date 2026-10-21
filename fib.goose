// fib.goose — Fibonacci numbers (recursive)

recursive fn fib(n: i64) -> i64 {
    if n <= 1 { return n; }
    return fib(n - 1) + fib(n - 2);
}

fn main() {
    print("fib(0)  = ", fib(0));
    print("fib(1)  = ", fib(1));
    print("fib(10) = ", fib(10));
    print("fib(20) = ", fib(20));
}
