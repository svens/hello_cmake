cmake_minimum_required(VERSION 3.8)

project(alib)

add_library(alib
	print.hpp
	print.cpp
)
target_include_directories(alib PUBLIC ..)

add_library(hello::alib ALIAS alib)
