import math

class Example:
    def __init__(self, value: int):
        self.name = "GitHub Theme"
        self.value = value
        self.is_active = True

    def calculate(self, factor):
        if self.value > 0:
            return self.value * factor + 100
        return None

def main():
    item = Example(123)
    result = item.calculate(0.5)
    print(f"{item.name}: {result}")

if __name__ == "__main__":
    main()
