//
// Created by Physiker on 1/19/2024.
//

// Note, for reasons unknown to me, without the inclusion of a cpp file, CMake will not properly handle the NASM code,
// and it will simply not assemble, with several errors. To see this for yourself, simply remove the VPF.cpp from the
// CMakeLists.txt file, in the NASM directory.

// There is no need for a main function here, or anything like that. There simply needs to be a cpp file, in the same
// directory as the asm source, and everything else works fine from there.