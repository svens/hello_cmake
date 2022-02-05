#include <alib/print.hpp>
#include <blib/hello.hpp>
#include <cstdlib>


int main ()
{
	alib::print("starting");
	blib::hello("world");
	alib::print("stopping");
	return EXIT_SUCCESS;
}
