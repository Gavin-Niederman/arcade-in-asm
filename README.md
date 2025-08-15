# Student-Centered Arcade Drive

The state of the VEX V5 platform is dire.

## The Issue

The REC Foundation states:

> Teams should create code that reflects the capabilities of their team members.

Further, the REC Foundation provides this example of a violoation of its Student-Centered Policy:

> Students are unable to explain the code functionality or development without a mentor’s assistance.

In practice, almost every competitor is using huge amounts of code that they have never looked at, and do not have the ability to recreate.
Some of the biggest sources of this issue include:

- LemLib
  - Implements complicated controls algorithms, removing the skill and knowledge required to use them under normal circumstances
- PROS
  - Uses the closed source VEX Partner SDK to access hardware APIs
  - Includes helper APIs such as motor groups
  - Implements very advanced concepts such as Hot/Cold linking through advanced linker script and build system configuration
- VEXCode
  - Completely closed source, so students couldn't look at it if they tried
  - Maintained by a for profit company
  - Very commonly used by beginner programmers due to its block code and python support
- vexide
  - High barrier of entry to reading its source code due to the Rust language
  - Uses assembly language to implement several complex features such as startup and differential uploading
  - Makes use of advanced Rust language features

These four libraries and runtimes are used in thousands of codebases and are often used in the most competetive teams. Clearly, something must change.

## The Solution

This repo, student-centered-arcade-drive, is the perfect remedy to this widespread issue. This codebase is an implementation of arcade drive, but, notably, it is fully self contained. It has exactly 0 external dependencies, including compiler intrinsics. Additionally, you may notice that there is no automated build system. Users are required to reference the *ARM ® Architecture Reference Manual ARMv7-A and ARMv7-R edition* in order to manually translate each line of assembly into a hex representation. Next, you can manually flip a digital switch connected to the data line of the serial port on the brain to use the Brain's serial protocol without any external code.

As a rational individual, you may be wondering "Is this actually Student-Centered? I'm still using your code as a base..."

According to the REC Foundation, this is fine!

> Students use the pre-installed programs as a starting point to build more developed programs.

Have fun developing!

> [!NOTE]
> This document is satire.