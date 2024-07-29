#!/bin/bash

if pgrep -x "kitty" > /dev/null; then
  kitty @ new-window
else
  nohup kitty &> /dev/null &
fi
