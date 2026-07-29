
const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{
        .preferred_optimize_mode = .ReleaseFast,
    });
    const vs_mode = b.option(bool, "vs-mode", "Target installation into the vs game repo, put the files into the correct subfolders.") orelse false;

    const debug_flags   = &[_][]const u8{ "-O0", "-DDEBUG", "-g", "-fno-sanitize=undefined" };
    const release_flags = &[_][]const u8{ "-O2", "-DNDEBUG", "-fno-sanitize=undefined" };

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

    if (vs_mode) {
        // VS specific paths
        const platform = switch (target.result.os.tag) {
            .linux   => "linux",
            .windows => "win",
            .macos   => "osx",
            else => "", // should maybe error here
        };
        const arch = switch (target.result.cpu.arch) {
            .x86_64 => "x64",
            .aarch64 => "arm64",
            else => "", // should maybe error here
        };

        const dst_slug = try std.fmt.allocPrint(b.allocator, "runtimes/{s}-{s}/native", .{ platform, arch });

        b.getInstallStep().dependOn(&b.addInstallArtifact(lib, .{
            .dest_dir   = .{ .override = .{ .custom =  dst_slug } },
            .pdb_dir    = if (optimize == .Debug) .{ .override = .{ .custom =  dst_slug } } else .disabled,
            .implib_dir = .disabled,
        }).step);
    }
    else {
        b.installArtifact(lib);
    }
}
