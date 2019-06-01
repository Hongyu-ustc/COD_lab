CC = iverilog
TARGET = my_multi_cycle_cpu
IM_DATA_FILE = mem.hex
SIMULATION_TIME = 4000

all:	run
build:
		$(CC) -DIM_DATA_FILE="\"$(IM_DATA_FILE)\"" \
                -DNUM_IM_DATA=`wc -l $(IM_DATA_FILE) | awk {'print $$1'}` \
				-DSIM_TIME=$(SIMULATION_TIME) \
                *.v -o $(TARGET)

run:		build
		./$(TARGET)

clean:
		rm -rf $(TARGET)
