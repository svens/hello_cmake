cmake_minimum_required(VERSION 3.8)

project(hello)

add_executable(hello
	src/main.cpp
)

target_include_directories(hello PRIVATE src)

target_link_libraries(hello
	hello::alib
	hello::blib
)
