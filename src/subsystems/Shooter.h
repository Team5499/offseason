#pragma once
#include <WPILib.h>
#include "../controllers/PController.h"
#include "../controllers/PLightController.h"

class Shooter {
private:

    CANTalon BottomFlyWheel;
    CANTalon TopFlyWheel;
    CANTalon FeedWheel;
    CANTalon ArmPivot;
    PController ArmController;

    PLightController TopController;
    PLightController BotController;

    double CurrentArmSetpoint;

public: 
    Shooter();

    void UpdatePID();

    void Lower();
    void RaiseArm();
    void Feed();
    void stopFeed();

    void ShootWheels();
    void StopWheels();
    
    void SetArmAngle(double angle);
    void SetWheelSpeed(double top, double bot);
};