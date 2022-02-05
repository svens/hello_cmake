list(APPEND hello_sources
	hello/main.cpp
)

add_executable(hello ${hello_sources})
target_link_libraries(hello hello::blib hello::alib)
