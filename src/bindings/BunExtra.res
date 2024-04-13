@module("bun") @variadic
external shell: (array<string>, array<string>) => promise<'output> = "$"
