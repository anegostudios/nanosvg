solution "nanosvg"
	configurations { "Debug", "Release"}
	location "build"

project "nanosvg"
	language "C"
	targetdir "build"
	platforms {"native", "x64", "x32"}
	kind "SharedLib"
	
	includedirs { "src" }
	files { "src/**.c", "src/**.h" }

	defines { 
		"NANOSVG_IMPLEMENTATION",
		"NANOSVGRAST_IMPLEMENTATION", 
		"NANOSVG_ALL_COLOR_KEYWORDS"
	}

	configuration "Debug"
		defines {"DEBUG"}
		flags {"Symbols"}

	configuration "Release"
		defines {"NDEBUG"}
		flags {"Optimize"}
