# cmake "hello, world"

[![Build](https://github.com/svens/hello_cmake/workflows/Build/badge.svg)](https://github.com/svens/hello_cmake/actions?query=workflow:Build)

CMake is not a build tool but rather a build system generation tool because it reads
project building description and generates required files for specified
buildsystem (GNU Makefiles, Ninja, Visual Studio solution file, etc).
Official tutorial can be found
[here](https://cmake.org/cmake/help/latest/guide/tutorial/index.html).

This project is a walk-through of CMake from:
* [command line](cli.md)
* [Visual Studio](msvc.md)
* [build pipeline](pipeline.md)

While generating build system files, it is possible to let cmake choose its own depending on build host and/or installed toolchain.
In [command line](cli.md) walkthrough we show both approaches.

> *Note:* <br>
> There is no point to change generated buildsystem files because cmake will overwrite the modifications. 
> We only have to edit the CMakeLists.txt file and CMAKE will automatically regenerate the buildsystem files to update the list of sources, build flags, and so on.


## Sample project

This project builds the C++ "hello, world" program in an overly complex way to demonstrate splitting code into modules:
* alib: independent library providing generic function `alib::print(message)`.
  It uses only C++ language features and STL (iostream, string)
* blib: intermediate library providing welcoming function `blib::hello(who)`.
  It uses alib's printing functionality.
* hello: application depending directly on alib and blib (while blib depends on alib)


## Versions

There are multiple versions of exactly the same application, just CMake project
description is organised differently. Whichever to choose, is personal
preference. In this walk-through, we use v1.


### v1

Usual C/C++ code organisation with separate directories: `include` and `src`

    ~/src/hello_cmake/v1 $ tree
    .
    ├── CMakeLists.txt
    ├── alib
    │   ├── CMakeLists.txt
    │   ├── include
    │   │   └── alib
    │   │       └── print.hpp
    │   └── src
    │       └── print.cpp
    ├── blib
    │   ├── CMakeLists.txt
    │   ├── include
    │   │   └── blib
    │   │       └── hello.hpp
    │   └── src
    │       └── hello.cpp
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
    │   ├── CMakeLists.txt
    │   ├── print.cpp
    │   └── print.hpp
    ├── blib
    │   ├── CMakeLists.txt
    │   ├── hello.cpp
    │   └── hello.hpp
    └── hello
        ├── CMakeLists.txt
        └── main.cpp


### v3

Same approach as v2, except submodules are used with `include()` instead of
`add_subdirectory()`. From the project hierarchy perspective, this is little
different from v2 but in build directory, all targets will be in root
directory (within build type directory). Depending on situation, this may be
more convenient (for example, if wrapper script needs to copy files somewhere,
etc)

    ~/src/hello_cmake/v3 $ tree
    .
    ├── CMakeLists.txt
    ├── alib
    │   ├── list.cmake
    │   ├── print.cpp
    │   └── print.hpp
    ├── blib
    │   ├── hello.cpp
    │   ├── hello.hpp
    │   └── list.cmake
    └── hello
        ├── list.cmake
        └── main.cpp


### v4

Possible approach for repositories containing multiple major independent
targets and their shared dependencies. Here, 'hello' is a major target, 'alib' +
'blib' are its dependencies. This approach does not litter root directory with
unrelated stuff but at same time building each major target will construct separate
copy of its dependencies.

    ~/src/hello_cmake/v4 $ tree
    .
    ├── alib
    │   ├── CMakeLists.txt
    │   ├── print.cpp
    │   └── print.hpp
    ├── blib
    │   ├── CMakeLists.txt
    │   ├── hello.cpp
    │   └── hello.hpp
    └── hello
        ├── CMakeLists.txt
        └── main.cpp
