# Changelog

## [1.3.0](https://github.com/akinsho/horizon.nvim/compare/v1.2.0...v1.3.0) (2023-06-23)


### Features

* **lsp:** add inlay hint highlight ([0dcaf33](https://github.com/akinsho/horizon.nvim/commit/0dcaf337897441eb7a322e9b068b01abbed705fa))
* **plugins:** add flash.nvim support ([a187357](https://github.com/akinsho/horizon.nvim/commit/a1873570f3ec75ca2ab45961429c62bc52102c8a))
* **plugins:** darken nvim-notify border colours ([11518d0](https://github.com/akinsho/horizon.nvim/commit/11518d014ceca0e7d0ff24b0468d2c81c38542eb))
* **theme:** add variable color for identifier ([65a9906](https://github.com/akinsho/horizon.nvim/commit/65a9906b823aca85fae9890d80574f95b28c0f87))
* **theme:** map color column highlight ([a1151ff](https://github.com/akinsho/horizon.nvim/commit/a1151ff429b2a1c2bc5a7477f6eb4b689aef7494))


### Bug Fixes

* **lsp:** don't italicise codelens separators ([c2c44c8](https://github.com/akinsho/horizon.nvim/commit/c2c44c836694f3b3c777d38e97f4515c456e2ea8))

## [1.2.0](https://github.com/akinsho/horizon.nvim/compare/v1.1.0...v1.2.0) (2023-04-20)


### Features

* **convert:** add ansi colours to palette ([e0b0d1c](https://github.com/akinsho/horizon.nvim/commit/e0b0d1c3a27be9f8492b091117e49f5defc10e0c))
* **theme:** improve TS Rainbow colours ([cb3f546](https://github.com/akinsho/horizon.nvim/commit/cb3f5467e19652e00ed67471695d4566626cca61))

## [1.1.0](https://github.com/akinsho/horizon.nvim/compare/v1.0.0...v1.1.0) (2023-04-19)


### Features

* **config:** allow users to specify overrides ([a72ad52](https://github.com/akinsho/horizon.nvim/commit/a72ad5286e7d70ead33fdf039a296f3d4486a795))
* **theme:** add a text emphasis highlight ([15971d3](https://github.com/akinsho/horizon.nvim/commit/15971d34c85a510b19a6541401d5ad2799bc2ffa))
* **theme:** add ok color to custom highlights ([32aa8aa](https://github.com/akinsho/horizon.nvim/commit/32aa8aa3a57b35fd38202f15370907295e9ac2ba))
* **theme:** change Directory highlight ([ccb06d3](https://github.com/akinsho/horizon.nvim/commit/ccb06d3c2fd5eac32cfa394239ceece6c4cc052d))

## 1.0.0 (2023-04-18)


### ⚠ BREAKING CHANGES

* **theme:** use original color palette (more)
* **build:** change colour blending function
* **theme:** align colors more closely with original
* **treesitter:** remove outdated TS.* highlights

### Features

* add highlights for neotree ([c966f23](https://github.com/akinsho/horizon.nvim/commit/c966f23be4ad2b2d22cd64823143815fae22a6ae))
* add lsp semantic tokens ([2434bfd](https://github.com/akinsho/horizon.nvim/commit/2434bfd8d887dc90af338c3a8d0d2b31d66fc67f))
* add TS rainbow, text link and other highlights ([4943d4f](https://github.com/akinsho/horizon.nvim/commit/4943d4ff2c825eba81ec1bfa858e04b2ba27e298))
* **build:** add a script to convert vscode colours ([ae99c64](https://github.com/akinsho/horizon.nvim/commit/ae99c64f56bd790cc4fc683a8bb376cf070d7dde))
* **build:** add float highlights ([a3bf049](https://github.com/akinsho/horizon.nvim/commit/a3bf0490ebddd6035934858a2d8dcbf93b8341b3))
* fork lunarvim/horizon.nvim ([9556a9e](https://github.com/akinsho/horizon.nvim/commit/9556a9ec18f2d1c02a4f9f1da1b298aade4a2633))
* generate palettes for light and dark mode ([e888d2b](https://github.com/akinsho/horizon.nvim/commit/e888d2b1ba231434e37b72179736c83c8f09364b))
* **neotree:** update highlights ([deb352c](https://github.com/akinsho/horizon.nvim/commit/deb352c017326cc937f36dd46b497497f2430490))
* **plugins:** add static folder icon colour ([1026733](https://github.com/akinsho/horizon.nvim/commit/10267336e23849543457ae1f4ac126900494231c))
* **theme:** highlight builtin variables ([2434bfd](https://github.com/akinsho/horizon.nvim/commit/2434bfd8d887dc90af338c3a8d0d2b31d66fc67f))
* **theme:** improve file explorer plugin highlights ([6d6831c](https://github.com/akinsho/horizon.nvim/commit/6d6831c1b3da0977dc74d2c1392dd94fbcc961cb))


### Bug Fixes

* add some commented out hl groups ([3623e7b](https://github.com/akinsho/horizon.nvim/commit/3623e7bfe3de9a7c7407b7942f49a66eece620c0))
* **build:** parse all token colours ([cea54a7](https://github.com/akinsho/horizon.nvim/commit/cea54a7c6571165f1b6dd8cac999c4cb340551fa))
* **build:** reverse cursor highlights ([4cf15ea](https://github.com/akinsho/horizon.nvim/commit/4cf15ead80baf60145a477dfbaf485ec9e50e33f))
* **init:** don't explicitly set background value ([0465677](https://github.com/akinsho/horizon.nvim/commit/0465677024260027d3069d7a6ee3cdf0a34b33b5))
* **overrides:** manually override diff removed ([a57af4a](https://github.com/akinsho/horizon.nvim/commit/a57af4aada5c2df9e362cef38e003bcaaf812feb))
* **plugins:** enable indentline plugin by default ([8185c14](https://github.com/akinsho/horizon.nvim/commit/8185c141f6fc135a6d71f489225717bca4a74ea7))
* TSVariableBuiltin should be yellow ([86ba82b](https://github.com/akinsho/horizon.nvim/commit/86ba82bcb51ce474a798debb473f954eb6a59819))


### Code Refactoring

* **build:** change colour blending function ([0840f05](https://github.com/akinsho/horizon.nvim/commit/0840f05c65b5c1b066abeb31a74d014191848ad1))
* **theme:** align colors more closely with original ([49d48ca](https://github.com/akinsho/horizon.nvim/commit/49d48ca36cdbeb196350bea379d810019ba7c59e))
* **theme:** use original color palette (more) ([e6ad0d0](https://github.com/akinsho/horizon.nvim/commit/e6ad0d08a48855489b76ae047bbc81629b863d47))
* **treesitter:** remove outdated TS.* highlights ([3e5c6dc](https://github.com/akinsho/horizon.nvim/commit/3e5c6dcf8460da1ece70bda1b00cfc5bcbb9c882))
