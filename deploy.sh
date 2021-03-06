#!/bin/bash
TEAM_NUMBER=$1
PROGRAM=$2
ROBOTCOMMAND=$3
TARGET_USER=lvuser
TARGET_DIR=/home/lvuser
# Probe for connection
TARGET="roborio-$TEAM_NUMBER-frc.local"
echo "Probing for $TARGET..."

#ssh "$USER@$TARGET" true &> /dev/null


#ping $TARGET &> /dev/null
#if [[ $? -eq 0 ]]; then
#    echo "Removing old program..."
#    ssh "$TARGET_USER@$TARGET" "rm -f $TARGET_DIR/FRCUserProgram"
#    echo "Copying over new program..."
#    scp "$PROGRAM" "$TARGET_USER@$TARGET:$TARGET_DIR/FRCUserProgram"
#    echo "Stoping netconsole-host..."
#    ssh "$TARGET_USER@$TARGET" "killall -q netconsole-host || :"
#    echo "Copying over robotCommand..." 
#    scp "$ROBOTCOMMAND" "$TARGET_USER@$TARGET:$TARGET_DIR"
#    echo "Cleaning up..."
#    ssh "$TARGET_USER@$TARGET" ". /etc/profile.d/natinst-path.sh;
#                              chmod a+x $TARGET_DIR/FRCUserProgram;
#                              /usr/local/frc/bin/frcKillRobot.sh -t -r;
#                              sync"
#    exit
#fi
P1=${TEAM_NUMBER:0:2}
P2=${TEAM_NUMBER:2:2}
TARGET="10.$P1.$P2.2"
echo "Not found - probing for $TARGET..."
ping $TARGET -c 1 &> /dev/null
if [[ $? -eq 0 ]]; then
    echo "Removing old program..."
    ssh "$TARGET_USER@$TARGET" "rm -f $TARGET_DIR/FRCUserProgram"
    echo "Copying over new program..."
    scp "$PROGRAM" "$TARGET_USER@$TARGET:$TARGET_DIR/FRCUserProgram"
    echo "Stopping netconsole-host..."
    ssh "$TARGET_USER@$TARGET" "killall -q netconsole-host || :"
    echo "Copying over robotCommand..." 
    scp "$ROBOTCOMMAND" "$TARGET_USER@$TARGET:$TARGET_DIR"
    echo "Cleaning up..."
    ssh "$TARGET_USER@$TARGET" ". /etc/profile.d/natinst-path.sh;
                              chmod a+x $TARGET_DIR/FRCUserProgram;
                              /usr/local/frc/bin/frcKillRobot.sh -t -r;
                              sync"
    exit
fi
echo "Not found - giving up."
