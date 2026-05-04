cmake_minimum_required(VERSION 3.23)

project(CFakeInput)
add_library(CFakeInput)

target_sources(CFakeInput
    PRIVATE
    ./CBindFakeInput.c
    PUBLIC
    ./CBindFakeInput.h
)