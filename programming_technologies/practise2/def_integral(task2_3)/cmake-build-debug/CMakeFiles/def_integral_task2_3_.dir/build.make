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
CMAKE_SOURCE_DIR = "/work/projects/polytech/cpp/def_integral(task2_3)"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/work/projects/polytech/cpp/def_integral(task2_3)/cmake-build-debug"

# Include any dependencies generated for this target.
include CMakeFiles/def_integral_task2_3_.dir/depend.make
# Include the progress variables for this target.
include CMakeFiles/def_integral_task2_3_.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/def_integral_task2_3_.dir/flags.make

CMakeFiles/def_integral_task2_3_.dir/main.cpp.o: CMakeFiles/def_integral_task2_3_.dir/flags.make
CMakeFiles/def_integral_task2_3_.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/work/projects/polytech/cpp/def_integral(task2_3)/cmake-build-debug/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/def_integral_task2_3_.dir/main.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/def_integral_task2_3_.dir/main.cpp.o -c "/work/projects/polytech/cpp/def_integral(task2_3)/main.cpp"

CMakeFiles/def_integral_task2_3_.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/def_integral_task2_3_.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/work/projects/polytech/cpp/def_integral(task2_3)/main.cpp" > CMakeFiles/def_integral_task2_3_.dir/main.cpp.i

CMakeFiles/def_integral_task2_3_.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/def_integral_task2_3_.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/work/projects/polytech/cpp/def_integral(task2_3)/main.cpp" -o CMakeFiles/def_integral_task2_3_.dir/main.cpp.s

# Object files for target def_integral_task2_3_
def_integral_task2_3__OBJECTS = \
"CMakeFiles/def_integral_task2_3_.dir/main.cpp.o"

# External object files for target def_integral_task2_3_
def_integral_task2_3__EXTERNAL_OBJECTS =

def_integral_task2_3_: CMakeFiles/def_integral_task2_3_.dir/main.cpp.o
def_integral_task2_3_: CMakeFiles/def_integral_task2_3_.dir/build.make
def_integral_task2_3_: CMakeFiles/def_integral_task2_3_.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/work/projects/polytech/cpp/def_integral(task2_3)/cmake-build-debug/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable def_integral_task2_3_"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/def_integral_task2_3_.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/def_integral_task2_3_.dir/build: def_integral_task2_3_
.PHONY : CMakeFiles/def_integral_task2_3_.dir/build

CMakeFiles/def_integral_task2_3_.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/def_integral_task2_3_.dir/cmake_clean.cmake
.PHONY : CMakeFiles/def_integral_task2_3_.dir/clean

CMakeFiles/def_integral_task2_3_.dir/depend:
	cd "/work/projects/polytech/cpp/def_integral(task2_3)/cmake-build-debug" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/work/projects/polytech/cpp/def_integral(task2_3)" "/work/projects/polytech/cpp/def_integral(task2_3)" "/work/projects/polytech/cpp/def_integral(task2_3)/cmake-build-debug" "/work/projects/polytech/cpp/def_integral(task2_3)/cmake-build-debug" "/work/projects/polytech/cpp/def_integral(task2_3)/cmake-build-debug/CMakeFiles/def_integral_task2_3_.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/def_integral_task2_3_.dir/depend
