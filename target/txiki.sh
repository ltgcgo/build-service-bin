#!/bin/bash
function init {
	#sudo apt install -y build-essential
	# Zig is installed via GitHub Actions
	sudo apt install -y tree cmake make
	sudo apt install -y libatomic1 libatomic1-amd64-cross libatomic1-arm64-cross libatomic1-riscv64-cross
	#sudo apt install -y libffi-dev
}

function build_txiki_triple {
	local os=$1
	local osCmake=$2
	local archLTGC=$3
	local archLLVM=$4
	local abi=$5
	local tripleLTGC="${archLTGC}-${os}-${abi}"
	local tripleLLVM="${archLLVM}-${os}-${abi}"
	local fileExt=""
	if [ "$os" == "windows" ]; then
		fileExt=".exe"
	fi

	rm -rf "dist-${tripleLTGC}" 2>/dev/null

	CC="zig cc -target ${tripleLLVM}" \
	CXX="zig c++ -target ${tripleLLVM}" \
	cmake -S . -B "dist-${tripleLTGC}" \
		-DCMAKE_SYSTEM_NAME="${osCmake}" \
		-DCMAKE_SYSTEM_PROCESSOR="${archLLVM}" \
		-DCMAKE_ASM_COMPILER="$(command -v zig)" \
		-DCMAKE_ASM_COMPILER_ARG1="cc -target ${tripleLLVM}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_WITH_FFI="${BUILD_WITH_FFI:-OFF}" \
		-DCMAKE_C_FLAGS="-Wno-error=date-time"

	cmake --build "dist-${tripleLTGC}" --target tjs-cli --parallel
	cmake --build "dist-${tripleLTGC}" --target tjsc --parallel

	mv -v "dist-${tripleLTGC}/tjs${fileExt}" "dist/tjs-${tripleLTGC}${fileExt}"
	mv -v "dist-${tripleLTGC}/tjsc${fileExt}" "dist/tjsc-${tripleLTGC}${fileExt}"
}

init
mkdir -p build
git clone https://github.com/saghul/txiki.js source --recursive --shallow-submodules
cd source
mkdir -p dist
build_txiki_triple linux Linux amd64 x86_64 gnu
build_txiki_triple linux Linux amd64 x86_64 musl
#build_txiki_triple linux Linux arm64 aarch64 gnu
#build_txiki_triple linux Linux arm64 aarch64 musl
#build_txiki_triple linux Linux riscv64 riscv64 gnu
#build_txiki_triple linux Linux riscv64 riscv64 musl
#build_txiki_triple windows Windows amd64 x86_64 gnu
#build_txiki_triple windows Windows arm64 aarch64 gnu
mv -v dist/* ../build/
cd ..
rm -r source
cd build
bash ../sh/post.sh
cd ..
exit