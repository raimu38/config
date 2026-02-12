fn main() {
    let name: &str = "GitHub Dark";
    let version: f64 = 9.1;
    let is_ready: bool = true;

    if is_ready {
        println!("Welcome to {}, version: {}", name, version);
    }

    let result = calculate(10);
    println!("Result: {}", result);
}

fn calculate(val: i32) -> i32 {
    val * 2 + 100
}
