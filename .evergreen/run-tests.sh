#!/bin/bash

set -o xtrace   # Write all commands first to stderr
set -o errexit  # Exit the script with error if any of the commands fail

# Supported/used environment variables:
#       MONGODB_URI             Set the suggested connection MONGODB_URI (including credentials and topology info)
#       TOPOLOGY                Allows you to modify variables and the MONGODB_URI based on test topology
#                               Supported values: "server", "replica_set", "sharded_cluster"
#       JDK                     Set the version of java to be used.  Java versions can be set from the java toolchain /opt/java
#                               "jdk7", "jdk8"

MONGODB_URI=${MONGODB_URI:-}
TOPOLOGY=${TOPOLOGY:-server}
JDK=${JDK:-jdk}
export JAVA_HOME="/opt/java/${JDK}"

############################################
#            Main Program                  #
############################################

# Provision the correct connection string
if [ "$TOPOLOGY" == "sharded_cluster" ]; then
     export MONGODB_URI="mongodb://localhost:27017"
fi

echo "Running tests with ${JDK} for $TOPOLOGY and connecting to $MONGODB_URI"

./gradlew -version
./gradlew -Dorg.mongodb.test.uri=${MONGODB_URI} --stacktrace --info test
