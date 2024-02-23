CXX := g++

SRCDIR := src
BUILD_DIR := build
EXECUTABLE := dessin-cc

CXXFLAGS := -std=c++17 -Wall -Wextra -Wpedantic -ggdb

BISON_OUTPUT := $(SRCDIR)/lexer-parser/parser.cpp $(SRCDIR)/lexer-parser/parser.hpp $(SRCDIR)/lexer-parser/location.hh
FLEX_OUTPUT := $(SRCDIR)/lexer-parser/scanner.cpp

SOURCES := $(shell find $(SRCDIR) -type f \( -name '*.cpp' -o -name '*.cc' \) -not -name '*parser.cpp' -a -not -name '*scanner.cpp')
# Add bison/flex generated files to the sources
SOURCES += $(SRCDIR)/lexer-parser/parser.cpp $(SRCDIR)/lexer-parser/scanner.cpp

HEADERS := $(shell find $(SRCDIR) -type f \( -name '*.h' -o -name '*.hh' \) -not -name '*parser.hpp' -a -not -name '*location.hh')
# Add bison generated headers to headers
HEADERS += $(SRCDIR)/lexer-parser/parser.hpp $(SRCDIR)/lexer-parser/location.hh

OBJECTS := $(patsubst $(SRCDIR)/%.cpp, $(BUILD_DIR)/%.o, $(SOURCES))

.PHONY: all clean

all: $(EXECUTABLE) $(SOURCES) $(HEADERS)

$(BUILD_DIR)/%.o: $(SRCDIR)/%.cpp $(HEADERS)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(BISON_OUTPUT): $(SRCDIR)/lexer-parser/parser.yy
	bison -Wcounterexamples -d -o $(SRCDIR)/lexer-parser/parser.cpp $<

$(FLEX_OUTPUT): $(SRCDIR)/lexer-parser/scanner.ll
	flex --c++ -o $(SRCDIR)/lexer-parser/scanner.cpp $<

$(EXECUTABLE): $(BISON_OUTPUT) $(FLEX_OUTPUT) $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJECTS)

clean:
	$(RM) -r $(EXECUTABLE) $(BUILD_DIR) $(BISON_OUTPUT) $(FLEX_OUTPUT)
