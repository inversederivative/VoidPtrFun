#Enable ASM provided by NASM
enable_language(ASM_NASM)


if(APPLE)
    #Add leading underscore when building macho64 object files
    string(APPEND CLION_ASM_NASM_FLAGS "--prefix _")
endif(APPLE)


# If the goal is to interact with C++ code and assembly code, calling convention
#  changes between platform, some adjustment on the assembly code is required.

# The following will pre-define a NASM macro "WIN32". This permit to conditionally assemble
#  code in the following manner :
#   %ifdef WIN32
#      ; code for Windows ABI
#      ; RCX, RDX, R8, R9
#   %else
#      ; code for System V AMD64 ABI
#      ; RDI, RSI, RDX, RCX, R8, R9
#   %endif
if(WIN32)
    string(APPEND CLION_ASM_NASM_FLAGS "-dWIN32=1")
endif(WIN32)


set(IS_DEBUG_BUILD CMAKE_BUILD_TYPE STREQUAL "Debug")

# Indication to the code that this is a debug build
if (${IS_DEBUG_BUILD})
    set(CMAKE_ASM_NASM_FLAGS "-g -dDEBUG")
endif ()

add_executable(VoidPtrNASM
        VPF.cpp
        VPF.asm
)