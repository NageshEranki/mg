if(NOT dune-mg_FOUND)
# Whether this module is installed or not
set(dune-mg_INSTALLED OFF)

# Settings specific to the module

# Package initialization
# Set prefix to source dir
set(PACKAGE_PREFIX_DIR /home/munna/dune/dune-2.6.0/dune-mg)
macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

#report other information
set_and_check(dune-mg_PREFIX "${PACKAGE_PREFIX_DIR}")
set_and_check(dune-mg_INCLUDE_DIRS "/home/munna/dune/dune-2.6.0/dune-mg")
set(dune-mg_CXX_FLAGS "-std=c++14 -DNDEBUG -O3 -ffast-math")
set(dune-mg_CXX_FLAGS_DEBUG "-g")
set(dune-mg_CXX_FLAGS_MINSIZEREL "-Os -DNDEBUG")
set(dune-mg_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
set(dune-mg_CXX_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG")
set(dune-mg_DEPENDS "dune-common;dune-geometry;dune-uggrid;dune-grid;dune-alugrid;dune-istl;dune-localfunctions;dune-typetree;dune-functions;dune-pdelab")
set(dune-mg_SUGGESTS "")
set(dune-mg_MODULE_PATH "/home/munna/dune/dune-2.6.0/dune-mg/cmake/modules")
set(dune-mg_LIBRARIES "")

# Lines that are set by the CMake build system via the variable DUNE_CUSTOM_PKG_CONFIG_SECTION


#import the target
if(dune-mg_LIBRARIES)
  get_filename_component(_dir "${CMAKE_CURRENT_LIST_FILE}" PATH)
  include("${_dir}/dune-mg-targets.cmake")
endif()
endif()
