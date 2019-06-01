CC = iverilog
TARGET = a.out
VCD_FILE = tb.vcd

all: view

run: build
	./$(TARGET)

build:
	$(CC) -o $(TARGET) *.v

view: run
	gtkwave $(VCD_FILE)
clean:
	rm -rf ./$(TARGET)
	rm -rf ./$(VCD_FILE)
