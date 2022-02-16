# Using cmake from pipeline

There are many public build pipelines ([GitHub
Actions](https://docs.github.com/en/actions), [Azure DevOps
Pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/get-started/what-is-azure-pipelines),
[Travis CI](https://docs.travis-ci.com/), etc). While they differ in details,
fundamentally they are same: provide build host that invokes project-specific
build system.

For this walk-through, we are going to use GitHub Actions. It provides Linux,
MacOS and Windows hosts. For multi-platform building demonstration, we are
going to use Linux and Windows. As a "best practise", try to use as little as
possible host-specific knowledge. Instead use cmake own capabilities for
building, testing and/or file operations (invoke `cmake -E --help` for more
information).

Sample action implementation is [here](TODO) and latest
invocations in project [actions](https://github.com/svens/hello_cmake/actions).
