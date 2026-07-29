
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{
        .preferred_optimize_mode = .ReleaseFast,
    });

    const debug_flags   = &[_][]const u8{ "-O0", "-DDEBUG", "-g" };
    const release_flags = &[_][]const u8{ "-O2", "-DNDEBUG" };

    const c_flags = if (optimize == .Debug) debug_flags else release_flags;

    const mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .strip = (optimize != .Debug),
    });

    mod.addIncludePath(b.path("include"));
    mod.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{
            "nanosvg.c",
            "nanosvgrast.c",
        },
        .flags = c_flags,
    });


    const lib = b.addLibrary(.{
        .name = "nanosvg",
        .root_module = mod,
        .linkage = .dynamic,
    });

    // ./zig-out/lib/libnanosvg.so, ./zig-out/bin/nanosvg.dll
    b.installArtifact(lib);
}
