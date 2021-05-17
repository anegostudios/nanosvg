solution "nanosvg"
	configurations { "Debug", "Release"}

project "nanosvg"
	language "C"
	platforms {"native", "x64", "x32"}
	kind "SharedLib"
	
	includedirs { "include" }
	files { "src/*.c" }

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
