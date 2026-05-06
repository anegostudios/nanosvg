workspace "nanosvg"
    configurations { "Release", "Debug" }

project "nanosvg"
    language "C"
    kind "SharedLib"
    
    includedirs { "include" }
    files { "src/*.c" }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

    filter {}