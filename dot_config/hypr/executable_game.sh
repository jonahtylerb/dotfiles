#!/bin/bash

hyprlit
AMBIENT_PID=$!

steam -tenfoot

kill $AMBIENT_PID
