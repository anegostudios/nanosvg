solution "nanosvg"
	configurations { "Debug", "Release"}

project "nanosvg"
	language "C"
	platforms {"native", "x64", "x32"}
	kind "SharedLib"
	
	includedirs { "include" }
	files { "src/*.c" }

	configuration "Debug"
		defines {"DEBUG"}
		flags {"Symbols"}

	configuration "Release"
		defines {"NDEBUG"}
		flags {"Optimize"}
