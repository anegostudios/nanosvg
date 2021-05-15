solution "nanosvg"
	configurations { "Debug", "Release"}
	location "build"

project "nanosvg"
	language "C"
	targetdir "build"
	platforms {"native", "x64", "x32"}
	kind "SharedLib"
	
	files {"src/*.h"}

	configuration "Debug"
		defines {"DEBUG"}
		flags {"Symbols"}

	configuration "Release"
		defines {"NDEBUG"}
		flags {"Optimize"}
