CC = iverilog
TARGET = lab3
IM_DATA_FILE = IMem_init.hex
DM_DATA_FILE = DMem_init.hex

all: run

build:
	$(CC) *.v -o $(TARGET)

run:	build
	./$(TARGET)

clean:
	rm -rf $(TARGET)