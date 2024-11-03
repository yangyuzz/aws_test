#!/bin/bash

GITHUB_ID="yangyuzz"
REPO_NAME="aws_test"
PROJECT_NAME="boot_hello"
PROJECT_PID="$(pgrep -f ${PROJECT_NAME}.jar)"
JAR_PATH="${HOME}/${REPO_NAME}/${PROJECT_NAME}/build/libs/${PROJECT_NAME}.jar"

export GITHUB_ID
export REPO_NAME
export PROJECT_NAME
export PROJECT_VERSION
export PROJECT_PID
export JAR_PATH
