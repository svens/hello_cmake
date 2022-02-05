cmake_minimum_required(VERSION 3.8)

project(alib)

add_library(alib
	include/alib/print.hpp
	src/print.cpp
)
target_include_directories(alib PUBLIC include)

add_library(hello::alib ALIAS alib)
