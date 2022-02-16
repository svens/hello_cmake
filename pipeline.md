# Using cmake from pipeline

There are many public build pipelines ([GitHub
Actions](https://docs.github.com/en/actions), [Azure DevOps
Pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/get-started/what-is-azure-pipelines),
[Travis CI](https://docs.travis-ci.com/), etc). While they differ in details,
fundamentally they are same: provide build host that invokes project-specific
build system.

For this walk-through, we are going to use GitHub Actions. It provides Linux,
MacOS and Windows hosts. For multi-platform building demonstration, we are
going to use Linux and Windows. As a best practise, try to use as little as
possible host-specific knowledge. Instead use cmake own capabilities for
building, testing and/or file operations. Invoke `cmake -E --help` for more
information:

    $ cmake -E --help
    CMake Error: cmake version 3.22.2
    Usage: cmake -E <command> [arguments...]
    Available commands:
      capabilities              - Report capabilities built into cmake in JSON format
      cat <files>...            - concat the files and print them to the standard output
      chdir dir cmd [args...]   - run command in a given directory
      compare_files [--ignore-eol] file1 file2
                                  - check if file1 is same as file2
      copy <file>... destination  - copy files to destination (either file or directory)
      copy_directory <dir>... destination   - copy content of <dir>... directories to 'destination' directory
      copy_if_different <file>... destination  - copy files if it has changed
      echo [<string>...]        - displays arguments as text
      echo_append [<string>...] - displays arguments as text but no new line
      env [--unset=NAME]... [NAME=VALUE]... COMMAND [ARG]...
                                - run command in a modified environment
      environment               - display the current environment
      make_directory <dir>...   - create parent and <dir> directories
      md5sum <file>...          - create MD5 checksum of files
      sha1sum <file>...         - create SHA1 checksum of files
      sha224sum <file>...       - create SHA224 checksum of files
      sha256sum <file>...       - create SHA256 checksum of files
      sha384sum <file>...       - create SHA384 checksum of files
      sha512sum <file>...       - create SHA512 checksum of files
      remove [-f] <file>...     - remove the file(s), use -f to force it (deprecated: use rm instead)
      remove_directory <dir>... - remove directories and their contents (deprecated: use rm instead)
      rename oldname newname    - rename a file or directory (on one volume)
      rm [-rRf] <file/dir>...    - remove files or directories, use -f to force it, r or R to remove directories and their contents recursively
      sleep <number>...         - sleep for given number of seconds
      tar [cxt][vf][zjJ] file.tar [file/dir1 file/dir2 ...]
                                - create or extract a tar or zip archive
      time command [args...]    - run command and display elapsed time
      touch <file>...           - touch a <file>.
      touch_nocreate <file>...  - touch a <file> but do not create it.
      create_symlink old new    - create a symbolic link new -> old
      create_hardlink old new   - create a hard link new -> old
      true                      - do nothing with an exit code of 0
      false                     - do nothing with an exit code of 1

Sample action implementation is [here](.github/workflows/build.yml) and latest
invocations in project [actions](https://github.com/svens/hello_cmake/actions).
Because pipeline build host is temporary environment, there is no need to
separate source and build directories but it still can be done, of course.
