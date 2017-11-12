#g++ -std=c++1z -Wall -g *.cpp -o htserv -lboost_system-mt -lws2_32 -lwsock32

BIN=htserv
BUILD_DIR=./build
TARGET=$(BUILD_DIR)/$(BIN)
CXX=g++
CXXFLAGS=-std=c++1z -Wall -g -Werror
LDFLAGS=
LDLIBS=-lboost_system-mt -lws2_32 -lwsock32
OBJ_DIR=./obj
SRC_DIR=./src
SRC=$(shell find $(SRC_DIR) -name '*.cpp')
HEADERS=$(shell find $(SRC_DIR) -name '*.h')
#https://www.gnu.org/software/make/manual/html_node/Text-Functions.html
OBJ=$(addprefix $(OBJ_DIR)/,$(notdir $(patsubst %.cpp, %.o, $(SRC))))

#http://stackoverflow.com/a/1951111/8715
dir_guard=@mkdir -p $(@D)


.PHONY: clean

all: $(TARGET)

$(TARGET): $(OBJ)
	$(dir_guard)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

#To cause recompile when .h files are change
$(OBJ):	$(SRC)
#$(HEADERS)
	$(dir_guard)
	$(CXX) $(CXXFLAGS) -c $? $(LDLIBS)
#Put all the object files in the correct directory
	@mv *.o $(OBJ_DIR)



clean:
	rm -rf $(BUILD_DIR)/* $(OBJ_DIR)/*
