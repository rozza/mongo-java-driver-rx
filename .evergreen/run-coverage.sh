#!/bin/bash

set -o xtrace   # Write all commands first to stderr
set -o errexit  # Exit the script with error if any of the commands fail

# Supported/used environment variables:
#       MONGODB_URI             Set the suggested connection MONGODB_URI (including credentials and topology info)

MONGODB_URI=${MONGODB_URI:-}
export JAVA_HOME="/opt/java/jdk8"

############################################
#            Main Program                  #
############################################

echo "Running coverage"

./gradlew -version
./gradlew -PxmlReports.enabled=true -Dorg.mongodb.test.uri=${MONGODB_URI} --stacktrace --info testCoverage
