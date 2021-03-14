cmake_minimum_required(VERSION 2.6 FATAL_ERROR)
project(cs344)

find_package(OpenCV REQUIRED)
find_package(CUDA REQUIRED)

link_libraries(${OpenCV_LIBS} )

set (EXECUTABLE_OUTPUT_PATH "${CMAKE_SOURCE_DIR}/bin/")

if(CUDA_FOUND)
  # compared to class settings, we let NVidia's FindCUDA CMake detect 
  # whether to build x64.  We tell it to support most devices, though, 
  # to make sure more people can easily run class code without knowing 
  # about this compiler argument
  set(CUDA_NVCC_FLAGS "
  -ccbin /usr/bin/g++; 
  -gencode;arch=compute_30,code=sm_30;  
  -gencode;arch=compute_35,code=sm_35;
  -gencode;arch=compute_35,code=compute_35;")

  set(CUDA_NVCC_FLAGS_DEBUG ${CUDA_NVCC_FLAGS_DEBUG} "-G")


  add_subdirectory ("psets/pset1")
  #add_subdirectory ("psets/pset2")
  #add_subdirectory ("psets/pset3")
  #add_subdirectory ("psets/pset4")
  #add_subdirectory ("psets/pset5")
  #add_subdirectory ("psets/pset6")

else(CUDA_FOUND)
  message("CUDA is not installed on this system.")
endif()
