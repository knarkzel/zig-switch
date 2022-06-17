const std = @import("std");

const devkitpro = "/opt/devkitpro";

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const obj = b.addObject("zig-switch", "src/main.zig");
    obj.setOutputDir("zig-out");
    obj.linkLibC();
    obj.setLibCFile(std.build.FileSource{ .path = "libc.txt" });
    obj.addIncludeDir(devkitpro ++ "/libnx/include");
    obj.setTarget(.{
        .cpu_arch = .aarch64,
        .os_tag = .freestanding,
        .abi = .eabi,
        .cpu_model = .{ .explicit = &std.Target.aarch64.cpu.cortex_a57 },
    });
    obj.setBuildMode(mode);

    const elf = b.addSystemCommand(
        &.{
            devkitpro ++ "/devkitA64/bin/aarch64-none-elf-gcc",
            "zig-out/zig-switch.o",
            "-g",
            "-march=armv8-a+crc+crypto",
            "-mtune=cortex-a57",
            "-mtp=soft",
            "-fPIE",
            "-Wl,-Map,zig-out/zig-switch.map",
            "-L" ++ devkitpro ++ "/libnx/lib",
            "-lnx",
            "-o",
            "zig-out/zig-switch.elf",
        },
    );

    b.default_step.dependOn(&elf.step);
    elf.step.dependOn(&obj.step);
}