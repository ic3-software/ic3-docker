#!/bin/sh

# -----------------------------------------------------------------------------
# The icCube.sh being installed in the image that is used to start icCube.
#
# An ad-hoc version of this file might be passed to the container using Volumes
# and/or Bind Mounts (see run_bind_mounts.sh / run_bind_mounts_files.sh).
# -----------------------------------------------------------------------------

JAVA=java

#
# icCube installation (edit)
#
ICCUBE=$( cd "$( dirname "$0" )/.." && pwd )

# There is no need to define those environment variables like that as this is the default behavior.
# Especially, do not define ICCUBE_LICENSE as we want to be able to start wo/ license now.
# Kept as a way to know about those variables used by icCube internally if required.
#
# icCube configuration file. Use the existing ICCUBE_CONFIGURATION otherwise the default from install.
# Handy when run from a Docker.
#
# if [ -z "$ICCUBE_CONFIGURATION" ]; then
# ICCUBE_CONFIGURATION=$ICCUBE/bin/icCube.xml
# fi
#
# icCube LOG4J configuration file. Use the existing ICCUBE_LOG4J_CONFIGURATION otherwise the default from install.
# Handy when run from a Docker.
#
# if [ -z "$ICCUBE_LOG4J_CONFIGURATION" ]; then
# ICCUBE_LOG4J_CONFIGURATION=$ICCUBE/bin/log4j.xml
# fi
#
# icCube license file. Use the existing ICCUBE_LICENSE otherwise the default from install.
# Handy when run from a Docker.
#
# if [ -z "$ICCUBE_LICENSE" ]; then
# ICCUBE_LICENSE=$ICCUBE/bin/icCube-4.lic
# fi
#
# export ICCUBE_LICENSE ICCUBE_CONFIGURATION ICCUBE_LOG4J_CONFIGURATION

#
# Redefining java.io.tmpdir because cdp4j is attempting to create the folder cdp4j into that directory.
# This might lead to access rights issue when using several icCube users on the machine. Ensure to have
# a different java.io.tmpdir for each user.
#
ICCUBE_USER=$(id -nu)
ICCUBE_TMPDIR=/tmp/$ICCUBE_USER

mkdir -p "$ICCUBE_TMPDIR"

#
# icCube JAVA setup
#
ICCUBE_JAVA_OPTS_EX="-DicCube.install=$ICCUBE -Djava.io.tmpdir=$ICCUBE_TMPDIR"

#
# Use the existing env. ICCUBE_JAVA_OPTS otherwise default to -Xmx512m only.
# Handy when run from a Docker to set the JVM memory (and others).
#
if [ -z "$ICCUBE_JAVA_OPTS" ]; then
  ICCUBE_JAVA_OPTS="-Xmx512m"
fi

# -----------------------------------------------------------------------------
# Out Of Memory Options
#
# -XX:+HeapDumpOnOutOfMemoryError
#
#     A heap dump is written on the first Out Of Memory Error.
#     There is no overhead involved unless a OOM actually occurs.
#
# -XX:HeapDumpPath=/home/ic3/dumps .
#
#     Note that the dump file can be huge, up to Gigabytes,
#     so ensure that the target file system has enough space.
# -----------------------------------------------------------------------------

#
# ICCUBE_JAVA_CP :
#
#       when run from Docker allows for adding an extra folder
#       for custom jars (e.g., JDBC driver).
#
# ICCUBE_CMD_LINE :
#
#       when run from Docker allows for executing special command.
#
# exec: when used from a Docker keep PID=1 to make a clean Docker stop
#
exec $JAVA $ICCUBE_JAVA_OPTS $ICCUBE_JAVA_OPTS_EX -cp "$ICCUBE_JAVA_CP:$ICCUBE/lib/*" crazydev.iccube.server.IcCubeServer $ICCUBE_CMD_LINE