#!/bin/bash

# Check if the script is running in an interactive shell
if [[ $- != *i* ]]; then
  return
fi

# Add to ~/.bashrc if necessary
echo -e "# ~/.bashrc: executed by bash(1) for non-login shells.\n\n# If not running interactively, don't do anything\ncase \$- in\n    *i*) ;;\n    *) return;;\nesac" >> ~/.bashrc
