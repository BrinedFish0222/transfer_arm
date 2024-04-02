# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(native_library_library VERSION 0.0.1 LANGUAGES C)

add_library(native_library SHARED
  "native_library.c"
)

set_target_properties(native_library PROPERTIES
  PUBLIC_HEADER native_library.h
  OUTPUT_NAME "native_library"
)

target_compile_definitions(native_library PUBLIC DART_SHARED_LIB)
