cmake_minimum_required(VERSION 3.8)

project(blib)

add_library(blib
	hello.hpp
	hello.cpp
)

target_include_directories(blib PUBLIC ..)
target_link_libraries(blib hello::alib)

add_library(hello::blib ALIAS blib)
