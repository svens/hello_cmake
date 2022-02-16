# Using cmake from command line

With cmake it is customary to keep projects sources and build directory
separate. It has many advantages:
* developer does not accidentally commit unnecessary intermediate files
* .gitignore file does not need to be overly noisy
* and so on

Build directory can be completely out of source directory or some subdirectory
of project. In following we will keep it completely separate. For starters,
let's assume our starting working directory is within project root directory
(for example, `~/src/hello_cmake`). Let's create build directory:

    ~/src/hello_cmake $ mkdir -p ../build && cd ../build
    ~/src/build $ _


## cmake

As we will be using cmake itself to invoke actual build system, we do not need
to care which one it chooses:

    ~/src/build $ cmake ../hello_cmake/v1
    -- The C compiler identification is AppleClang 12.0.0.12000032
    [.. skip some output ..]
    -- Build files have been written to: /home/user/src/build
    ~/src/build $ _

While not important in this case, it created GNU Makefile with clang toolchain
for me. To build project, let cmake do it for us:

    ~/src/build $ cmake --build .
    [ 16%] Building CXX object alib/CMakeFiles/alib.dir/src/print.cpp.o
    [ 33%] Linking CXX static library libalib.a
    [.. skip some output ..]
    [100%] Linking CXX executable hello
    [100%] Built target hello
    ~/src/build $ _

And now we can run our "hello, world" application:

    ~/src/build $ ./hello/hello
    starting
    hello, world
    stopping
    ~/src/build $ _

For completeness, here is the way how different target can be build (clean for
our purposes):

    ~/src/build $ cmake --build . --target clean
    ~/src/build $ _


## Ninja

If defaults are not satisfactory for any reason, we can also tell cmake to
generate files for specific build system, toolchain and build configuration.
For example, let's create build files that use Ninja + GNU toolchain with
debug build type (other possibilities are Release, RelWithDebInfo and so on,
see cmake documentation):

    ~/src/build $ CC=gcc-11 CXX=g++-11 cmake ../hello_cmake/v1 -G Ninja -DCMAKE_BUILD_TYPE=Debug
    -- The C compiler identification is GNU 11.2.0
    [.. skip some output ..]
    -- Build files have been written to: /home/user/src/build
    ~/src/build $ _

We can invoke ninja indirectly with cmake like above or start ninja directly
(it's personal preference, I myself simply type 'ninja' faster):

    ~/src/build $ ninja
    [6/6] Linking CXX executable hello/hello
    ~/src/build $ _

To get all the possible target names, ninja has special target named 'help':

    ~/src/build $ ninja help
    [1/1] All primary targets available:
    edit_cache: phony
    rebuild_cache: phony
    alib/edit_cache: phony
    alib/rebuild_cache: phony
    blib/edit_cache: phony
    blib/rebuild_cache: phony
    hello/edit_cache: phony
    hello/rebuild_cache: phony
    alib: phony
    blib: phony
    hello: phony
    libalib.a: phony
    libblib.a: phony
    all: phony
    build.ninja: RERUN_CMAKE
    clean: CLEAN
    help: HELP
    ~/src/build $ _

Why choose Ninja as build system? Again, this is personal preference but it is
small, lean and builds very fast.
