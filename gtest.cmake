#
# Download and build googletest/googlemock libraries 
#

find_package(Threads REQUIRED)

include(ExternalProject)

set(GTEST_PREFIX
  ${PROJECT_BINARY_DIR}/googletest
  )

ExternalProject_Add(
  googletest
  URL https://github.com/google/googletest/archive/release-1.8.0.zip
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/googletest

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
macro(define_imported_target target library)
  add_library(${target} IMPORTED STATIC GLOBAL)
  add_dependencies(${target} googletest)
  set_target_properties(${target} PROPERTIES
    IMPORTED_LOCATION ${library}
    IMPORTED_LINK_INTERFACE_LIBRARIES ${CMAKE_THREAD_LIBS_INIT}
    )
endmacro(define_imported_target)

# create imported target
set(LIBRARIES
  ${binary_dir}/googlemock/gtest/${CMAKE_STATIC_LIBRARY_PREFIX}gtest${CMAKE_STATIC_LIBRARY_SUFFIX}
  ${binary_dir}/googlemock/gtest/${CMAKE_STATIC_LIBRARY_PREFIX}gtest_main${CMAKE_STATIC_LIBRARY_SUFFIX}
  ${binary_dir}/googlemock/${CMAKE_STATIC_LIBRARY_PREFIX}gmock${CMAKE_STATIC_LIBRARY_SUFFIX}
  ${binary_dir}/googlemock/${CMAKE_STATIC_LIBRARY_PREFIX}gmock_main${CMAKE_STATIC_LIBRARY_SUFFIX}
  )

foreach(lib ${LIBRARIES})
  get_filename_component(target_lib "${lib}" NAME)
  string(REGEX REPLACE "^${CMAKE_STATIC_LIBRARY_PREFIX}" "" wo_pref ${target_lib})
  string(REGEX REPLACE "${CMAKE_STATIC_LIBRARY_SUFFIX}$" "" target ${wo_pref})
  define_imported_target(${target} ${lib})
endforeach()
