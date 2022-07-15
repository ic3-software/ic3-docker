#!/bin/sh

# -----------------------------------------------------------------------------
# The icCube.sh being installed in the image that is used to start icCube.
#
# For example, allows for configuring the RAM allocated to the JVM.
#
# An ad-hoc version of this file can be passed to the container using Volumes
# and/or Bind Mounts (see run_bind_mounts.sh / run_bind_mounts_files.sh).
# -----------------------------------------------------------------------------

JAVA=java

#
# icCube installation (edit)
#
ICCUBE=$( cd "$( dirname "$0" )/.." && pwd )

#
# icCube configuration file
#
ICCUBE_CONFIGURATION=$ICCUBE/bin/icCube.xml

#
# icCube LOG4J configuration file
#
ICCUBE_LOG4J_CONFIGURATION=$ICCUBE/bin/log4j.xml

#
# icCube license file
#
ICCUBE_LICENSE=$ICCUBE/bin/icCube-4.lic

export ICCUBE_LICENSE ICCUBE_CONFIGURATION ICCUBE_LOG4J_CONFIGURATION

#
# icCube JAVA setup
#
JAVA_OPTS="-Xmx512m -DicCube.install=$ICCUBE"

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
# exec: when used from a Docker keep PID=1 to make a clean Docker stop
#
exec $JAVA $JAVA_OPTS -cp "$ICCUBE/lib/*" crazydev.iccube.server.IcCubeServer
