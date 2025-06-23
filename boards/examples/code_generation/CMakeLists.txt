# Copyright (C) 2025 Fondazione Istituto Italiano di Tecnologia (IIT)  
# All Rights Reserved.
# Authors: Mattia Fussi <mattia.fussi@iit.it>

cmake_minimum_required(VERSION 3.28)

project(codegen_ex)

cmake_policy(SET CMP0076 NEW)

find_package(YARP REQUIRED)

add_executable(${PROJECT_NAME})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")

target_sources(${PROJECT_NAME}
  PUBLIC
  main.cpp
  mbd/code_generation_example.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC mbd)

target_link_libraries(${PROJECT_NAME} PRIVATE ${YARP_LIBRARIES})

install(TARGETS ${PROJECT_NAME} DESTINATION bin)
