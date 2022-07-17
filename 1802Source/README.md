<h1>CDP1802 Assembly Source</h1>
<p>
This is the source assembly for the code running on the emulated CDP1802 that powers the namebadge, as well as a tool to convert the output binary into a .png texture that can be imported into Unity.
<br>
Use the <a href="http://www.retrotechnology.com/memship/a18.html">A18 cross-assembler</a> to assemble using the command-line <code>./a18 main-vrc.asm -b vrc.bin -l vrc.lst</code> (works in PowerShell and bash).
<br>
The output binary is converted into a .png image using the provided tool. Compile once using <code>javac B2T.java</code>, and run using <code>java B2T vrc.bin</code>
<br>
If you do end up customizing the assembly, keep in mind that overwriting the program texture in the unity project will clear any custom sign text generated using the unity editor tool. The tool also assumes that the sign text is located at memory address 0200 hex, so you must not move the memory contents past the SIGN_TEXT label.
</p>
