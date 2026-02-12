#include <iostream>
#include <string>
#include <vector>

class Greeter {
public:
    Greeter(std::string n) : name(n) {}
    
    void sayHello() {
        bool should_print = true;
        if (should_print) {
            std::cout << "Hello, " << name << "!" << std::endl;
        }
    }

private:
    std::string name;
};

int main() {
    std::vector<int> nums = {1, 2, 3};
    Greeter g("Vim User");
    g.sayHello();
    return 0;
}
