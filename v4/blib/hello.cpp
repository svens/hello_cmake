#include <blib/hello.hpp>
#include <alib/print.hpp>

namespace blib
{

void hello (const std::string &who)
{
	alib::print("hello, " + who);
}

}
