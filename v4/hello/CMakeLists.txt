cmake_minimum_required(VERSION 3.8)

project(hello)

add_subdirectory(../alib alib)
add_subdirectory(../blib blib)

add_executable(hello
	main.cpp
)

target_link_libraries(hello
	hello::alib
	hello::blib
)
