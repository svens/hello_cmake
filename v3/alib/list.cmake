list(APPEND alib_sources
	alib/print.hpp
	alib/print.cpp
)

add_library(alib ${alib_sources})
add_library(hello::alib ALIAS alib)
