CC = iverilog
TARGET = my_single_cycle_cpu
IM_DATA_FILE = imem.hex
DM_DATA_FILE = dmem.hex
SIMULATION_TIME = 10000

all:	run
build:
		$(CC) -DIM_DATA_FILE="\"$(IM_DATA_FILE)\"" \
                -DNUM_IM_DATA=`wc -l $(IM_DATA_FILE) | awk {'print $$1'}` \
                -DDM_DATA_FILE="\"$(DM_DATA_FILE)\"" \
                -DNUM_DM_DATA=`wc -l $(DM_DATA_FILE) | awk {'print $$1'}` \
				-DSIM_TIME=$(SIMULATION_TIME) \
                *.v -o $(TARGET)

run:		build
		./$(TARGET)

clean:
		rm -rf *.vcd
		rm -rf $(TARGET)
