@echo off

pushd web
call yarn install
call yarn dev
popd