# Move by Example

## Directory description
- move-basic
- aptos
- starcoin
- sui
- 0L

move-basic can run on all move public chains. 
aptos,starcoin, sui, 0L ... can only run on its own chain

## How to contribute

1. Write move examples in `examples/` folder in each organization. For example, `src/move-basic/examples/sources`. And then test the examples with corresponding CLI tool.
2. Write doc in Markdown format, include corresponding move code in markdown file.
3. Update `src/SUMMARY.md`
4. Run `mdbook serve --open` to start a local server to check your changes as expected.
5. Pull request. 