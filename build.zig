const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "progrezzbar",
        .root_source_file = .{ .path = "src/progrezzbar.zig" }, // Library source file
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);

    const tests = b.addTest(.{
        .name = "progrezzbar_tests",
        .root_source_file = .{ .path = "src/tests.zig" }, // Test source file
        .deps = @dependencies([lib]), // Link tests with the library
        .target = target,
        .optimize = optimize,
    });

    const run_tests = b.addRunArtifact(tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_tests.step);
}