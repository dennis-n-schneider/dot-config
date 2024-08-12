#!/bin/sh

read -p "Task: " task_definition
$(task add "$task_definition")
