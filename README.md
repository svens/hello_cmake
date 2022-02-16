# cmake "hello, world"

CMake itself is not build tool but build system generation tool: it reads
project building description and generates required files for specified
buildsystem (GNU Makefiles, Ninja, Visual Studio solution file, etc).
Official tutorial can be found
[here](https://cmake.org/cmake/help/latest/guide/tutorial/index.html).

This project is not CMake tutorial but rather walk-through for using it from:
* [command line](cli.md)
* [Visual Studio](msvc.md)
* [build pipeline](pipeline.md)

While generating build system files, it is possible not to specify builder but
let cmake choose on it's own depending on build host and/or installed toolchain.
In [command line](cli.md) walkthrough we show both approaches.

> *Note*
> Because buildsystem files are generated, there is no point changing them,
> cmake will overwrite modifications. To update list of sources, build flags
> and so on, edit CMakeLists.txt instead and cmake automatically regenerates
> buildsystem files.


## Sample project

This "hello, world" project builds usual C++ "hello, world" application in
overly complex way to demonstrate splitting code into modules:
* alib: independent library providing generic function `alib::print(message)`.
  It uses only C++ language features and STL (iostream, string)
* blib: intermediate library providing welcoming function `blib::hello(who)`.
  It uses alib's printing functionality.
* hello: application itself, depends directly on alib and blib (while blib
  itself depends on alib)


## Versions

There are 3 versions of exactly same application, simply CMake project
description is organised differently. Whichever to choose, is personal
preference.


### v1

Usual C/C++ code organisation with separate `include` and `src` directories

    ~/src/hello_cmake/v1 $ tree
    .
    ├── CMakeLists.txt
    ├── alib
    │   ├── CMakeLists.txt
    │   ├── include
    │   │   └── alib
    │   │       └── print.hpp
    │   └── src
    │       └── print.cpp
    ├── blib
    │   ├── CMakeLists.txt
    │   ├── include
    │   │   └── blib
    │   │       └── hello.hpp
    │   └── src
    │       └── hello.cpp
    └── hello
        ├── CMakeLists.txt
        └── src
            └── main.cpp


### v2

Header and source files are kept side by side. This approach is more
convenient for command line users, allowing shorter filename patterns to
handle those pairs easier together (i.e. `print.?pp` specifies both header
and it's implementation source file).

    ~/src/hello_cmake/v2 $ tree
    .
    ├── CMakeLists.txt
    ├── alib
    │   ├── CMakeLists.txt
    │   ├── print.cpp
    │   └── print.hpp
    ├── blib
    │   ├── CMakeLists.txt
    │   ├── hello.cpp
    │   └── hello.hpp
    └── hello
        ├── CMakeLists.txt
        └── main.cpp


### v3

Same approach as v2, except submodules are used with `include()` instead of
`add_subdirectory()`

    ~/src/hello_cmake/v3 $ tree
    .
    ├── CMakeLists.txt
    ├── alib
    │   ├── list.cmake
    │   ├── print.cpp
    │   └── print.hpp
    ├── blib
    │   ├── hello.cpp
    │   ├── hello.hpp
    │   └── list.cmake
    └── hello
        ├── list.cmake
        └── main.cpp
