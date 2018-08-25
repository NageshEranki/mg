# Install script for directory: /home/munna/dune/dune-2.6.0/dune-mg/doc/doxygen

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RELEASE")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND /usr/bin/cmake --build /home/munna/dune/dune-2.6.0/dune-mg/build-cmake --target doxygen_dune-mg
          WORKING_DIRECTORY /home/munna/dune/dune-2.6.0/dune-mg/build-cmake/doc/doxygen)
        file(GLOB doxygenfiles
          GLOB /home/munna/dune/dune-2.6.0/dune-mg/build-cmake/doc/doxygen/html/*.html
          /home/munna/dune/dune-2.6.0/dune-mg/build-cmake/doc/doxygen/html/*.js
          /home/munna/dune/dune-2.6.0/dune-mg/build-cmake/doc/doxygen/html/*.png
          /home/munna/dune/dune-2.6.0/dune-mg/build-cmake/doc/doxygen/html/*.css
          /home/munna/dune/dune-2.6.0/dune-mg/build-cmake/doc/doxygen/html/*.gif)
        set(doxygenfiles "${doxygenfiles}")
        foreach(_file ${doxygenfiles})
           get_filename_component(_basename ${_file} NAME)
           LIST(APPEND CMAKE_INSTALL_MANIFEST_FILES /usr/local/share/doc/dune-mg/doxygen/${_basename})
         endforeach()
         file(INSTALL ${doxygenfiles} DESTINATION /usr/local/share/doc/dune-mg/doxygen)
         message(STATUS "Installed doxygen into /usr/local/share/doc/dune-mg/doxygen")
endif()

