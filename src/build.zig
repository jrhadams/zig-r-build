const std = @import("std");

const targets: []const std.Target.Query = &.{
    .{ .cpu_arch = .aarch64, .os_tag = .macos },
    .{ .cpu_arch = .aarch64, .os_tag = .linux },
    .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .gnu },
    .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .musl },
    .{ .cpu_arch = .x86_64, .os_tag = .windows },
};

pub fn build(b: *std.Build) void {
    //const target = std.Target.Query{ .cpu_arch = .x86_64, .os_tag = .linux }; //b.standardTargetOptions(.{});
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const muhlibrary = b.addSharedLibrary(.{
        .name = "zigrexample",
        .root_source_file = b.path("main.zig"),
        .target = target, //b.resolveTargetQuery(target),
        .optimize = optimize,
        .version = .{ .major = 1, .minor = 2, .patch = 3 },
    });
    //lib.setOutputDir(".");
    //lib.install();
    //muhlibrary.linkSystemLibrary("r");
    muhlibrary.linkSystemLibrary("c");
    muhlibrary.linkLibC();
    muhlibrary.addIncludePath(.{ .cwd_relative = "/usr/share/R/include/" });
    //muhlibrary.addIncludeDir("/usr/share/R/include");
    //muhlibrary.linkSystemLibrary("/usr/lib64/R/lib");
    //lib.addIncludeDir("/usr/share/R/include");
    //lib.force_pic = true;

    //    lib.setTarget(target);
    //lib.addBuildOption("-fPIC");
    //lib.linker_script = "-Bsymbolic-functions -z relro";
    //lib.linker_script = "-Bsymbolic-functions";
    //lib.linker_args.append("-Bsymbolic-functions");

    b.installArtifact(muhlibrary);
}
