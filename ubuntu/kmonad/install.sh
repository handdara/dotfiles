#!/bin/sh

# requires stack and git

git clone git@github.com:kmonad/kmonad.git
cd kmonad

stack build
stack haddock
stack install
