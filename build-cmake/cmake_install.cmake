# Install script for directory: /home/munna/dune/dune-2.6.0/dune-mg

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
  set(CMAKE_MODULE_PATH /home/munna/dune/dune-2.6.0/dune-mg/cmake/modules;/home/munna/dune/dune-2.6.0/dune-pdelab/cmake/modules;/home/munna/dune/dune-2.6.0/dune-functions/cmake/modules;/home/munna/dune/dune-2.6.0/dune-alugrid/cmake/modules;/home/munna/dune/dune-2.6.0/dune-localfunctions/cmake/modules;/home/munna/dune/dune-2.6.0/dune-istl/cmake/modules;/home/munna/dune/dune-2.6.0/dune-typetree/cmake/modules;/home/munna/dune/dune-2.6.0/dune-grid/cmake/modules;/home/munna/dune/dune-2.6.0/dune-uggrid/cmake/modules;/home/munna/dune/dune-2.6.0/dune-geometry/cmake/modules;/home/munna/dune/dune-2.6.0/dune-common/cmake/modules)
              set(DUNE_PYTHON_WHEELHOUSE /usr/local/share/dune/wheelhouse)
              include(DuneExecuteProcess)
              dune_execute_process(COMMAND "/usr/bin/cmake" --build . --target install_python --config $<CONFIG>)
              
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/dunecontrol/dune-mg" TYPE FILE FILES "/home/munna/dune/dune-2.6.0/dune-mg/dune.module")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/dune-mg" TYPE FILE FILES
    "/home/munna/dune/dune-2.6.0/dune-mg/build-cmake/cmake/pkg/dune-mg-config.cmake"
    "/home/munna/dune/dune-2.6.0/dune-mg/build-cmake/dune-mg-config-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/dune-mg" TYPE FILE FILES "/home/munna/dune/dune-2.6.0/dune-mg/config.h.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/munna/dune/dune-2.6.0/dune-mg/build-cmake/dune-mg.pc")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/munna/dune/dune-2.6.0/dune-mg/build-cmake/src/cmake_install.cmake")
  include("/home/munna/dune/dune-2.6.0/dune-mg/build-cmake/dune/cmake_install.cmake")
  include("/home/munna/dune/dune-2.6.0/dune-mg/build-cmake/doc/cmake_install.cmake")
  include("/home/munna/dune/dune-2.6.0/dune-mg/build-cmake/cmake/modules/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/munna/dune/dune-2.6.0/dune-mg/build-cmake/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
