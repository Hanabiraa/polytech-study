# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /snap/clion/164/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /snap/clion/164/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/work/projects/polytech/cpp/my_pow(loops5)"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/work/projects/polytech/cpp/my_pow(loops5)/cmake-build-debug"

# Include any dependencies generated for this target.
include CMakeFiles/my_pow_loops5_.dir/depend.make
# Include the progress variables for this target.
include CMakeFiles/my_pow_loops5_.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/my_pow_loops5_.dir/flags.make

CMakeFiles/my_pow_loops5_.dir/main.cpp.o: CMakeFiles/my_pow_loops5_.dir/flags.make
CMakeFiles/my_pow_loops5_.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/work/projects/polytech/cpp/my_pow(loops5)/cmake-build-debug/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/my_pow_loops5_.dir/main.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/my_pow_loops5_.dir/main.cpp.o -c "/work/projects/polytech/cpp/my_pow(loops5)/main.cpp"

CMakeFiles/my_pow_loops5_.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/my_pow_loops5_.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/work/projects/polytech/cpp/my_pow(loops5)/main.cpp" > CMakeFiles/my_pow_loops5_.dir/main.cpp.i

CMakeFiles/my_pow_loops5_.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/my_pow_loops5_.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/work/projects/polytech/cpp/my_pow(loops5)/main.cpp" -o CMakeFiles/my_pow_loops5_.dir/main.cpp.s

# Object files for target my_pow_loops5_
my_pow_loops5__OBJECTS = \
"CMakeFiles/my_pow_loops5_.dir/main.cpp.o"

# External object files for target my_pow_loops5_
my_pow_loops5__EXTERNAL_OBJECTS =

my_pow_loops5_: CMakeFiles/my_pow_loops5_.dir/main.cpp.o
my_pow_loops5_: CMakeFiles/my_pow_loops5_.dir/build.make
my_pow_loops5_: CMakeFiles/my_pow_loops5_.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/work/projects/polytech/cpp/my_pow(loops5)/cmake-build-debug/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable my_pow_loops5_"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/my_pow_loops5_.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/my_pow_loops5_.dir/build: my_pow_loops5_
.PHONY : CMakeFiles/my_pow_loops5_.dir/build

CMakeFiles/my_pow_loops5_.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/my_pow_loops5_.dir/cmake_clean.cmake
.PHONY : CMakeFiles/my_pow_loops5_.dir/clean

CMakeFiles/my_pow_loops5_.dir/depend:
	cd "/work/projects/polytech/cpp/my_pow(loops5)/cmake-build-debug" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/work/projects/polytech/cpp/my_pow(loops5)" "/work/projects/polytech/cpp/my_pow(loops5)" "/work/projects/polytech/cpp/my_pow(loops5)/cmake-build-debug" "/work/projects/polytech/cpp/my_pow(loops5)/cmake-build-debug" "/work/projects/polytech/cpp/my_pow(loops5)/cmake-build-debug/CMakeFiles/my_pow_loops5_.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/my_pow_loops5_.dir/depend
