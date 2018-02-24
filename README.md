# CMake external project scripts

This project contains some xxx.cmake files.

## Description

Each xxx.cmake uses CMake ExternalProject module.
That makes library setup simply

## Features

- gtest.cmake for GoogleTest/GoogleMock

## Requirements

- CMake 2.8.12 or later

## How to Use

1. Clone this repository

```
$ git clone https://github.com/trairia/cmake
```

2. Add cloned directory to CMAKE_MODULE_PATH

```CMakeLists.txt
set(CMAKE_MODULE_PATH path/to/cloned)
```

3. include cmake module

```CMakeLists.txt
include(gtest)
```

## Author

[@trairia](https://twitter.com/trairia)

## License

MIT