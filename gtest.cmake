#
# Download and build googletest/googlemock libraries 
#

find_package(Threads REQUIRED)

include(ExternalProject)

ExternalProject_Add(
  googletest
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/googletest
  URL "https://github.com/google/googletest/archive/master.zip"
  CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release
  INSTALL_COMMAND ""
)

ExternalProject_Get_Property(
  googletest
  source_dir binary_dir
  )

include_directories(
  ${source_dir}/googlemock/include
  ${source_dir}/googletest/include
  )

# macro to define imported target
macro(define_imported_target target libpath)
    add_library(${target} IMPORTED STATIC GLOBAL)
  add_dependencies(${target} googletest)
  set_target_properties(${target} PROPERTIES
    IMPORTED_LOCATION ${libpath}/${CMAKE_STATIC_LIBRARY_PREFIX}${target}${CMAKE_STATIC_LIBRARY_SUFFIX}
    IMPORTED_LOCATION_DEBUG ${libpath}/${CMAKE_STATIC_LIBRARY_PREFIX}${target}d${CMAKE_STATIC_LIBRARY_SUFFIX}
  )
  if (CMAKE_THREAD_LIBS_INIT)
    set_target_properties(${target} PROPERTIES
      IMPORTED_LINK_INTERFACE_LIBRARIES ${CMAKE_THREAD_LIBS_INIT}
    )
  endif()
endmacro(define_imported_target)

# create imported target
foreach(lib gtest gtest_main)
  define_imported_target(${lib} ${binary_dir}/googlemock/gtest)
endforeach()

foreach(lib gmock gmock_main)
  define_imported_target(${lib} ${binary_dir}/googlemock)
endforeach()
