CC = iverilog
TARGET = mycpu
IM_DATA_FILE = IMem_init.hex
DM_DATA_FILE = DMem_init.hex
build:
	$(CC) -DIM_DATA_FILE="\"$(IM_DATA_FILE)\"" \
		-DNUM_IM_DATA=`wc -l $(IM_DATA_FILE) | awk {'print $$1'}` \
		-DDM_DATA_FILE="\"$(DM_DATA_FILE)\"" \
		-DNUM_DM_DATA=`wc -l $(DM_DATA_FILE) | awk {'print $$1'}` \
		*.v -o $(TARGET)

run:
	./$(TARGET)

clean:
	rm -rf *.vcd
	rm -rf $(TARGET)