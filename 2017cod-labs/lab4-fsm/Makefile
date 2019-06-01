CC = iverilog
TARGET = myfsm
IM_DATA_FILE = ram.hex

all: run

build:
	$(CC) -DIM_DATA_FILE="\"$(IM_DATA_FILE)\"" \
		-DNUM_IM_DATA=`wc -l $(IM_DATA_FILE) | awk {'print $$1'}` \
		*.v -o $(TARGET)

run: build
	./$(TARGET)

clean:
	rm -rf *.vcd
	rm -rf $(TARGET)
