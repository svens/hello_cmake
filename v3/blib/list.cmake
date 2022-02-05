list(APPEND blib_sources
	blib/hello.hpp
	blib/hello.cpp
)

add_library(blib ${blib_sources})
add_library(hello::blib ALIAS blib)
target_link_libraries(blib hello::alib)
