macro(use_catch2 DIR)
   if (NOT Catch2::Catch2)
      if (NOT EXISTS ${DIR}/catch2)
         set(CATCH_BUILD_TESTING OFF CACHE BOOL "disable building tests")
         set(CATCH_INSTALL_DOCS OFF CACHE BOOL "disable installing docs")
         set(CATCH_INSTALL_HELPERS OFF CACHE BOOL "disable installing helpers")

         set(CATCH2_DIRECTORY ${DIR})
         configure_file(modules/catch2_install.cmake.in ${CMAKE_BINARY_DIR}/catch2-download/CMakeLists.txt @ONLY)
         execute_process(COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/catch2-download")
         execute_process(COMMAND "${CMAKE_COMMAND}" --build . WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/catch2-download")
         add_subdirectory(${DIR}/catch2 ${CMAKE_CURRENT_BINARY_DIR}/catch2)
         include(${DIR}/catch2/contrib/Catch.cmake)
      endif()
   endif()
endmacro()
